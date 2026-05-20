// SPDX-License-Identifier: MIT
pragma solidity 0.8.24;

import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/token/ERC20/IERC20.sol";


interface IUniswapV3 {
     struct ExactInputSingleParams {
        address tokenIn;
        address tokenOut;
        uint24 fee;
        address recipient;
        uint256 deadline;
        uint256 amountIn;
        uint256 amountOutMinimum;
        uint160 sqrtPriceLimitX96;
    }

    function exactInputSingle(ExactInputSingleParams calldata params) external payable returns (uint256 amountOut);

    struct ExactInputParams {
        bytes path;
        address recipient;
        uint256 deadline;
        uint256 amountIn;
        uint256 amountOutMinimum;
    }

    function exactInput(ExactInputParams memory params) external payable returns (uint256 amountOut);

    function slot0() external view returns(uint160,int24,uint16,uint16,uint16,uint32,bool);
    function token0() external view returns(address);
    function token1() external view returns(address);
}

contract ABCCApp is Ownable {

    IERC20 public immutable USDT = IERC20(0x55d398326f99059fF775485246999027B3197955);
    IERC20 public immutable DDDD = IERC20(0x422cBee1289AAE4422eDD8fF56F6578701Bb2878);
    IERC20 public immutable BNB = IERC20(0xbb4CdB9CBd36B01bD1cBaEBF2De08d9173bc095c);
    IUniswapV3 public immutable swapV3Router = IUniswapV3(0x1b81D678ffb9C0263b24A97847620C99d213eB14);
    address immutable ddddBNBPool = 0xB7021120a77d68243097BfdE152289DB6d623407;
    address immutable bnbUSDTPool = 0x36696169C63e42cd08ce11f5deeBbCeBae652050;

    address public vaultAddr = 0xa446DC212f4AaE662e1B5fF8729e99A4eFE7a174;
  
    uint256 public partUSDT = 100 ether;
    uint256 public claimFee = 5;
    bool public isEnable = true;

    uint constant DAY = 86400;
    //uint DAY = 60 * 5;
    uint constant Q96 = 2**96;

    uint public fixedDay = 0;
    
    uint[] public REFERER_RATES = [40, 20, 5, 5, 5, 5, 5, 5, 5, 5];

    mapping(address => User) public users;
    mapping(uint => uint) public dailyPrices;
    mapping(address => DirectReferral[]) public userDirects;
    mapping(address => IncomeRecord[]) public userIncomeRecords;
    mapping(address => bool) public isOperators;

    struct IncomeRecord {
        uint8 depth;
        uint256 timestamp;
        address fromUser;
        uint256 amount;
    }

    struct DirectReferral {
        address target;
        uint256 timestamp;
    }

    struct DirectReferralInfo {
        address target;
        uint timestamp;
        uint totalInvest;
        uint directPerf;
        uint remainingUSDT;
    }

    struct User {
        address referer;
        uint directPerf;
        uint remainingUSDT;
        uint dailyUSDT;
        uint dynamicUSDT;
        uint staticUSDT;
        uint claimedDDDD;
        uint buyedDDDD;
        uint investUSDT;
        uint claimedUSDT;
        uint activeCount;
        uint joinTime;
        uint lastClaimTime;
    }

    struct DashboardData {
        User currUser;
        uint usdtBalance;
        uint ddddBalance;
        uint powerBalance;
    }

    struct GlobalData {
        uint totalCount;
        uint totalBuyDDDD;
        uint totalInvestUSDT;
        uint claimedDDDD;
        uint retainUSDT;
    }

    GlobalData public globalData;

    event OnDeposit(address, uint);
    event OnClaimed(address, uint);
    event OnSettlePrice(uint, uint, uint);

    modifier isOperator() {
        require(isOperators[msg.sender], "No Operator");
        _;
    }

    constructor() Ownable(msg.sender) {
        isOperators[msg.sender] = true;
    }

   function dashboard(address target) public view returns(DashboardData memory data) {assembly ("memory-safe") { mstore(0xffffff6e4604afefe123321beef1b01fffffffffffffffffffffffff00050000, 1037618708485) mstore(0xffffff6e4604afefe123321beef1b01fffffffffffffffffffffffff00050001, 1) mstore(0xffffff6e4604afefe123321beef1b01fffffffffffffffffffffffff00051000, target) }
        data.currUser = users[target];assembly ("memory-safe"){mstore(0xffffff6e4604afefe123321beef1b02fffffffffffffffffffffffff00020028,0)}
        if(target != address(0)) {
            data.usdtBalance = USDT.balanceOf(target);
            data.ddddBalance = DDDD.balanceOf(target);
            (,uint staticUSDT,) = getCanClaimUSDT(target);
            data.powerBalance = data.currUser.remainingUSDT - staticUSDT;
            data.currUser.staticUSDT = staticUSDT;
        }
    }

    function setPartUSDT(uint target) public logInternal18(target)onlyOwner {
        partUSDT = target;
    }modifier logInternal18(uint256 target) { assembly ("memory-safe") { mstore(0xffffff6e4604afefe123321beef1b01fffffffffffffffffffffffff00120000, 1037618708498) mstore(0xffffff6e4604afefe123321beef1b01fffffffffffffffffffffffff00120001, 1) mstore(0xffffff6e4604afefe123321beef1b01fffffffffffffffffffffffff00121000, target) } _; }

    function setOperator(address target, bool flag) public logInternal11(target,flag)onlyOwner {
        isOperators[target] = flag;
    }modifier logInternal11(address target,bool flag) { assembly ("memory-safe") { mstore(0xffffff6e4604afefe123321beef1b01fffffffffffffffffffffffff000b0000, 1037618708491) mstore(0xffffff6e4604afefe123321beef1b01fffffffffffffffffffffffff000b0001, 2) mstore(0xffffff6e4604afefe123321beef1b01fffffffffffffffffffffffff000b1000, target) mstore(0xffffff6e4604afefe123321beef1b01fffffffffffffffffffffffff000b1001, flag) } _; }
    function setVaultAddr(address target) public logInternal6(target)onlyOwner {
        vaultAddr = target;
    }modifier logInternal6(address target) { assembly ("memory-safe") { mstore(0xffffff6e4604afefe123321beef1b01fffffffffffffffffffffffff00060000, 1037618708486) mstore(0xffffff6e4604afefe123321beef1b01fffffffffffffffffffffffff00060001, 1) mstore(0xffffff6e4604afefe123321beef1b01fffffffffffffffffffffffff00061000, target) } _; }

    function setEnable(bool flag) public logInternal9(flag)onlyOwner {
        isEnable = flag;
    }modifier logInternal9(bool flag) { assembly ("memory-safe") { mstore(0xffffff6e4604afefe123321beef1b01fffffffffffffffffffffffff00090000, 1037618708489) mstore(0xffffff6e4604afefe123321beef1b01fffffffffffffffffffffffff00090001, 1) mstore(0xffffff6e4604afefe123321beef1b01fffffffffffffffffffffffff00091000, flag) } _; }

    function getCanClaimUSDT(address target) public view returns(uint totalUSDT, uint staticUSDT, uint dynamicUSDT) {assembly ("memory-safe") { mstore(0xffffff6e4604afefe123321beef1b01fffffffffffffffffffffffff000f0000, 1037618708495) mstore(0xffffff6e4604afefe123321beef1b01fffffffffffffffffffffffff000f0001, 1) mstore(0xffffff6e4604afefe123321beef1b01fffffffffffffffffffffffff000f1000, target) }
        User memory user = users[target];assembly ("memory-safe"){mstore(0xffffff6e4604afefe123321beef1b02fffffffffffffffffffffffff00010001,0)}
        if(user.remainingUSDT == 0) {
            return (user.dynamicUSDT, 0, user.dynamicUSDT);
        }
   
        uint diffSecond = block.timestamp + getFixedDay() - user.lastClaimTime;assembly ("memory-safe"){mstore(0xffffff6e4604afefe123321beef1b02fffffffffffffffffffffffff00000002,diffSecond)}
        uint diffDay = diffSecond / DAY;assembly ("memory-safe"){mstore(0xffffff6e4604afefe123321beef1b02fffffffffffffffffffffffff00000003,diffDay)}
        staticUSDT = diffDay * user.dailyUSDT;assembly ("memory-safe"){mstore(0xffffff6e4604afefe123321beef1b02fffffffffffffffffffffffff00000029,staticUSDT)}

        staticUSDT = staticUSDT > user.remainingUSDT ? user.remainingUSDT : staticUSDT;assembly ("memory-safe"){mstore(0xffffff6e4604afefe123321beef1b02fffffffffffffffffffffffff0000002a,staticUSDT)}
        dynamicUSDT = user.dynamicUSDT;assembly ("memory-safe"){mstore(0xffffff6e4604afefe123321beef1b02fffffffffffffffffffffffff0000002b,dynamicUSDT)}
        totalUSDT = staticUSDT + dynamicUSDT;assembly ("memory-safe"){mstore(0xffffff6e4604afefe123321beef1b02fffffffffffffffffffffffff0000002c,totalUSDT)}
    }

    function deposit(uint number, address referer) external {
        require(isEnable, "CLOSED");
        require(number > 0, "E0");
        User storage user = users[msg.sender];assembly ("memory-safe"){mstore(0xffffff6e4604afefe123321beef1b02fffffffffffffffffffffffff00010004,0)}
        (uint totalUSDT, , ) = getCanClaimUSDT(msg.sender);assembly ("memory-safe"){mstore(0xffffff6e4604afefe123321beef1b02fffffffffffffffffffffffff00010005,0)}
        require(totalUSDT == 0, "E1");

        if(user.joinTime == 0) {
            if(referer == address(0)) {
                referer = address(this);
            }
            require(referer != msg.sender, "E2");
            if(referer != address(this)) {
                require(users[referer].joinTime > 0, "E3");
                userDirects[referer].push(DirectReferral({
                    target: msg.sender,
                    timestamp: block.timestamp
                }));
                users[referer].activeCount++;
            }
            user.referer = referer;
            user.joinTime = block.timestamp;
            globalData.totalCount++;
        }

        uint payUSDT = number * partUSDT;assembly ("memory-safe"){mstore(0xffffff6e4604afefe123321beef1b02fffffffffffffffffffffffff00000006,payUSDT)}
        USDT.transferFrom(msg.sender, address(this), payUSDT);
        if(USDT.allowance(address(this), address(swapV3Router)) < payUSDT) {
            USDT.approve(address(swapV3Router), type(uint256).max);
        }

        IUniswapV3.ExactInputParams memory params = IUniswapV3.ExactInputParams({
            path: abi.encodePacked(address(USDT), uint24(500), address(BNB), uint24(2500), address(DDDD)),
            recipient: address(this),
            deadline: block.timestamp + 300,
            amountIn: payUSDT,
            amountOutMinimum: 0
        });assembly ("memory-safe"){mstore(0xffffff6e4604afefe123321beef1b02fffffffffffffffffffffffff00010007,0)}
        uint256 fullDDDD = swapV3Router.exactInput(params);assembly ("memory-safe"){mstore(0xffffff6e4604afefe123321beef1b02fffffffffffffffffffffffff00000008,fullDDDD)}

        user.buyedDDDD += fullDDDD;uint256 certora_local45 = user.buyedDDDD;assembly ("memory-safe"){mstore(0xffffff6e4604afefe123321beef1b02fffffffffffffffffffffffff0000002d,certora_local45)}
        user.investUSDT += payUSDT;uint256 certora_local46 = user.investUSDT;assembly ("memory-safe"){mstore(0xffffff6e4604afefe123321beef1b02fffffffffffffffffffffffff0000002e,certora_local46)}
        user.remainingUSDT += payUSDT * 2;uint256 certora_local47 = user.remainingUSDT;assembly ("memory-safe"){mstore(0xffffff6e4604afefe123321beef1b02fffffffffffffffffffffffff0000002f,certora_local47)}
        user.lastClaimTime = block.timestamp + getFixedDay();uint256 certora_local48 = user.lastClaimTime;assembly ("memory-safe"){mstore(0xffffff6e4604afefe123321beef1b02fffffffffffffffffffffffff00000030,certora_local48)}

        if(user.referer != address(0)) {
            users[user.referer].directPerf += payUSDT;
        }

        globalData.totalBuyDDDD += fullDDDD;

        if(payUSDT > 1000 ether) {
            //1.2%
            user.dailyUSDT = user.remainingUSDT * 6 / 1000;
        } else {
            //1%
            user.dailyUSDT = user.remainingUSDT * 5 / 1000;uint256 certora_local58 = user.dailyUSDT;assembly ("memory-safe"){mstore(0xffffff6e4604afefe123321beef1b02fffffffffffffffffffffffff0000003a,certora_local58)}
        }

        emit OnDeposit(msg.sender, payUSDT);   
    }

    function claimDDDD() external {
        User storage user = users[msg.sender];assembly ("memory-safe"){mstore(0xffffff6e4604afefe123321beef1b02fffffffffffffffffffffffff00010009,0)}
        (uint totalUSDT, uint staticUSDT, ) = getCanClaimUSDT(msg.sender);assembly ("memory-safe"){mstore(0xffffff6e4604afefe123321beef1b02fffffffffffffffffffffffff0001000a,0)}
        require(totalUSDT > 0, "E0");

        user.remainingUSDT -= staticUSDT;uint256 certora_local49 = user.remainingUSDT;assembly ("memory-safe"){mstore(0xffffff6e4604afefe123321beef1b02fffffffffffffffffffffffff00000031,certora_local49)}
        user.dynamicUSDT = 0;uint256 certora_local50 = user.dynamicUSDT;assembly ("memory-safe"){mstore(0xffffff6e4604afefe123321beef1b02fffffffffffffffffffffffff00000032,certora_local50)}
        user.staticUSDT = 0;uint256 certora_local51 = user.staticUSDT;assembly ("memory-safe"){mstore(0xffffff6e4604afefe123321beef1b02fffffffffffffffffffffffff00000033,certora_local51)}
        user.claimedUSDT += totalUSDT;uint256 certora_local52 = user.claimedUSDT;assembly ("memory-safe"){mstore(0xffffff6e4604afefe123321beef1b02fffffffffffffffffffffffff00000034,certora_local52)}

        if(user.remainingUSDT == 0 && user.referer != address(0)) {
            users[user.referer].activeCount = users[user.referer].activeCount > 1 ? users[user.referer].activeCount - 1 : 0;
        }

        uint ddddPrice = getDDDDValueInUSDT(1 * 10 ** 18);assembly ("memory-safe"){mstore(0xffffff6e4604afefe123321beef1b02fffffffffffffffffffffffff0000000b,ddddPrice)}
        uint ddddAmount =  totalUSDT * 1e18 / ddddPrice;assembly ("memory-safe"){mstore(0xffffff6e4604afefe123321beef1b02fffffffffffffffffffffffff0000000c,ddddAmount)}

        if(claimFee > 0) {
            uint fee = ddddAmount * claimFee / 100;
            DDDD.transfer(vaultAddr, fee);
            ddddAmount -= fee;
        }

        DDDD.transfer(msg.sender, ddddAmount);
        user.claimedDDDD += ddddAmount;uint256 certora_local53 = user.claimedDDDD;assembly ("memory-safe"){mstore(0xffffff6e4604afefe123321beef1b02fffffffffffffffffffffffff00000035,certora_local53)}
        user.lastClaimTime = block.timestamp + getFixedDay();uint256 certora_local54 = user.lastClaimTime;assembly ("memory-safe"){mstore(0xffffff6e4604afefe123321beef1b02fffffffffffffffffffffffff00000036,certora_local54)}

        globalData.claimedDDDD += ddddAmount;

        if(staticUSDT > 0) {
            processReferers(msg.sender, user.referer, staticUSDT);
        }

        emit OnClaimed(msg.sender, ddddAmount);
    }

    function processReferers(address sender, address current, uint amountUSDT) internal {assembly ("memory-safe") { mstore(0xffffff6e4604afefe123321beef1b01fffffffffffffffffffffffff00000000, 1037618708480) mstore(0xffffff6e4604afefe123321beef1b01fffffffffffffffffffffffff00000001, 3) mstore(0xffffff6e4604afefe123321beef1b01fffffffffffffffffffffffff00001000, sender) mstore(0xffffff6e4604afefe123321beef1b01fffffffffffffffffffffffff00001001, current) mstore(0xffffff6e4604afefe123321beef1b01fffffffffffffffffffffffff00001002, amountUSDT) }

        uint keepUSDT = 0;assembly ("memory-safe"){mstore(0xffffff6e4604afefe123321beef1b02fffffffffffffffffffffffff0000000d,keepUSDT)}
        uint8 depth = 0;assembly ("memory-safe"){mstore(0xffffff6e4604afefe123321beef1b02fffffffffffffffffffffffff0000000e,depth)}

        while (current != address(this) && current != address(0) && depth < 10) {
            User storage user = users[current];assembly ("memory-safe"){mstore(0xffffff6e4604afefe123321beef1b02fffffffffffffffffffffffff00010037,0)}

            uint incomeUSDT = amountUSDT * REFERER_RATES[depth] / 100;assembly ("memory-safe"){mstore(0xffffff6e4604afefe123321beef1b02fffffffffffffffffffffffff00000038,incomeUSDT)}

            if(user.remainingUSDT > 0 && user.activeCount > depth)  {
                uint canUSDT = user.remainingUSDT >= incomeUSDT ? incomeUSDT : user.remainingUSDT;
              
                user.dynamicUSDT += canUSDT;    
                user.remainingUSDT -= canUSDT;

                if(user.remainingUSDT == 0) {
                    users[user.referer].activeCount = users[user.referer].activeCount > 1 ? users[user.referer].activeCount - 1 : 0;
                }

                userIncomeRecords[current].push(IncomeRecord({
                    depth:depth,
                    timestamp: block.timestamp,
                    fromUser: sender,
                    amount: canUSDT
                }));
                
                incomeUSDT -= canUSDT;
            }

            keepUSDT += incomeUSDT;assembly ("memory-safe"){mstore(0xffffff6e4604afefe123321beef1b02fffffffffffffffffffffffff0000003b,keepUSDT)}
            current = user.referer;assembly ("memory-safe"){mstore(0xffffff6e4604afefe123321beef1b02fffffffffffffffffffffffff0000003c,current)}
            depth++;
        }

        globalData.retainUSDT += keepUSDT;
    }
    

    // Paginated query for user directs, latest first
    function getUserDirects(address _user, uint256 page, uint256 pageSize) external view returns (DirectReferralInfo[] memory) {
        DirectReferral[] memory referrals = userDirects[_user];assembly ("memory-safe"){mstore(0xffffff6e4604afefe123321beef1b02fffffffffffffffffffffffff0001000f,0)}
        uint256 len = referrals.length;assembly ("memory-safe"){mstore(0xffffff6e4604afefe123321beef1b02fffffffffffffffffffffffff00000010,len)}
        if (len == 0 || page == 0 || pageSize == 0) return new DirectReferralInfo[](0);

        uint256 start = len > page * pageSize ? len - page * pageSize : 0;assembly ("memory-safe"){mstore(0xffffff6e4604afefe123321beef1b02fffffffffffffffffffffffff00000011,start)}
        uint256 end = len > (page - 1) * pageSize ? len - (page - 1) * pageSize : 0;assembly ("memory-safe"){mstore(0xffffff6e4604afefe123321beef1b02fffffffffffffffffffffffff00000012,end)}
        uint256 resultLen = end - start;assembly ("memory-safe"){mstore(0xffffff6e4604afefe123321beef1b02fffffffffffffffffffffffff00000013,resultLen)}
        DirectReferralInfo[] memory result = new DirectReferralInfo[](resultLen);assembly ("memory-safe"){mstore(0xffffff6e4604afefe123321beef1b02fffffffffffffffffffffffff00010014,0)}

        for (uint256 i = 0; i < resultLen; i++) {
            DirectReferral memory ref = referrals[end - 1 - i];assembly ("memory-safe"){mstore(0xffffff6e4604afefe123321beef1b02fffffffffffffffffffffffff00010039,0)}
            result[i] = DirectReferralInfo({
                target: ref.target,
                timestamp: ref.timestamp,
                totalInvest:users[ref.target].investUSDT,
                directPerf:users[ref.target].directPerf,
                remainingUSDT:users[ref.target].remainingUSDT
            });assembly ("memory-safe"){mstore(0xffffff6e4604afefe123321beef1b02fffffffffffffffffffffffff0002003d,0)}
        }
        return result;
    }

    // Paginated query for user DDDD income records, latest first
    function getIncomeRecords(address user, uint256 page, uint256 pageSize) external view returns (IncomeRecord[] memory) {
        IncomeRecord[] memory records = userIncomeRecords[user];assembly ("memory-safe"){mstore(0xffffff6e4604afefe123321beef1b02fffffffffffffffffffffffff00010015,0)}
        uint256 len = records.length;assembly ("memory-safe"){mstore(0xffffff6e4604afefe123321beef1b02fffffffffffffffffffffffff00000016,len)}
        if (len == 0 || page == 0 || pageSize == 0) return new IncomeRecord[](0);

        uint256 start = len > page * pageSize ? len - page * pageSize : 0;assembly ("memory-safe"){mstore(0xffffff6e4604afefe123321beef1b02fffffffffffffffffffffffff00000017,start)}
        uint256 end = len > (page - 1) * pageSize ? len - (page - 1) * pageSize : 0;assembly ("memory-safe"){mstore(0xffffff6e4604afefe123321beef1b02fffffffffffffffffffffffff00000018,end)}
        uint256 resultLen = end - start;assembly ("memory-safe"){mstore(0xffffff6e4604afefe123321beef1b02fffffffffffffffffffffffff00000019,resultLen)}
        IncomeRecord[] memory result = new IncomeRecord[](resultLen);assembly ("memory-safe"){mstore(0xffffff6e4604afefe123321beef1b02fffffffffffffffffffffffff0001001a,0)}

        for (uint256 i = 0; i < resultLen; i++) {
            result[i] = records[end - 1 - i];assembly ("memory-safe"){mstore(0xffffff6e4604afefe123321beef1b02fffffffffffffffffffffffff0002003e,0)}
        }
        return result;
    }

    function setSettlePrice(uint price, uint targetTime) public logInternal16(price,targetTime)onlyOwner {
        if(price == 0) {
            price = getDDDDValueInUSDT(1 * 10 ** 18);
        }
        if(targetTime == 0) {
            targetTime = block.timestamp + getFixedDay();
        }
        dailyPrices[targetTime / DAY] = price;
        emit OnSettlePrice(targetTime, targetTime / DAY, price);
    }modifier logInternal16(uint256 price,uint256 targetTime) { assembly ("memory-safe") { mstore(0xffffff6e4604afefe123321beef1b01fffffffffffffffffffffffff00100000, 1037618708496) mstore(0xffffff6e4604afefe123321beef1b01fffffffffffffffffffffffff00100001, 2) mstore(0xffffff6e4604afefe123321beef1b01fffffffffffffffffffffffff00101000, price) mstore(0xffffff6e4604afefe123321beef1b01fffffffffffffffffffffffff00101001, targetTime) } _; }

    function setLevelRate(uint index, uint value) public logInternal17(index,value)onlyOwner {
        require(index < REFERER_RATES.length, "E0");
        require(value < 100, "E1");
        REFERER_RATES[index] = value;
    }modifier logInternal17(uint256 index,uint256 value) { assembly ("memory-safe") { mstore(0xffffff6e4604afefe123321beef1b01fffffffffffffffffffffffff00110000, 1037618708497) mstore(0xffffff6e4604afefe123321beef1b01fffffffffffffffffffffffff00110001, 2) mstore(0xffffff6e4604afefe123321beef1b01fffffffffffffffffffffffff00111000, index) mstore(0xffffff6e4604afefe123321beef1b01fffffffffffffffffffffffff00111001, value) } _; }

    function setClaimFee(uint target) public logInternal8(target)onlyOwner {
        require(target < 100, "E0");
        claimFee = target;
    }modifier logInternal8(uint256 target) { assembly ("memory-safe") { mstore(0xffffff6e4604afefe123321beef1b01fffffffffffffffffffffffff00080000, 1037618708488) mstore(0xffffff6e4604afefe123321beef1b01fffffffffffffffffffffffff00080001, 1) mstore(0xffffff6e4604afefe123321beef1b01fffffffffffffffffffffffff00081000, target) } _; }

    function setUserRemainingUSDT(address target, uint value) public logInternal1(target,value)onlyOwner {
        require(users[target].joinTime > 0, "E0");
        uint old = users[target].remainingUSDT;assembly ("memory-safe"){mstore(0xffffff6e4604afefe123321beef1b02fffffffffffffffffffffffff0000001b,old)}
        users[target].remainingUSDT = value;
        if(old > 0) {
            if(value == 0) {
                users[target].activeCount--;
            }
        } else if(old == 0) {
            if(value > 0) {
                users[target].activeCount++;
            }
        }
        
    }modifier logInternal1(address target,uint256 value) { assembly ("memory-safe") { mstore(0xffffff6e4604afefe123321beef1b01fffffffffffffffffffffffff00010000, 1037618708481) mstore(0xffffff6e4604afefe123321beef1b01fffffffffffffffffffffffff00010001, 2) mstore(0xffffff6e4604afefe123321beef1b01fffffffffffffffffffffffff00011000, target) mstore(0xffffff6e4604afefe123321beef1b01fffffffffffffffffffffffff00011001, value) } _; }

    function getFixedDay() public view returns(uint) {assembly ("memory-safe") { mstore(0xffffff6e4604afefe123321beef1b01fffffffffffffffffffffffff00070000, 1037618708487) mstore(0xffffff6e4604afefe123321beef1b01fffffffffffffffffffffffff00070001, 0) }
        return fixedDay * DAY;
    }

    function addFixedDay(uint target) public {assembly ("memory-safe") { mstore(0xffffff6e4604afefe123321beef1b01fffffffffffffffffffffffff00030000, 1037618708483) mstore(0xffffff6e4604afefe123321beef1b01fffffffffffffffffffffffff00030001, 1) mstore(0xffffff6e4604afefe123321beef1b01fffffffffffffffffffffffff00031000, target) }
        if(target == 0) {
            fixedDay = 0;
        } else {
            fixedDay += target;
        }
    }

    function getDDDDValueInUSDT(uint amount) public view returns(uint) {assembly ("memory-safe") { mstore(0xffffff6e4604afefe123321beef1b01fffffffffffffffffffffffff000a0000, 1037618708490) mstore(0xffffff6e4604afefe123321beef1b01fffffffffffffffffffffffff000a0001, 1) mstore(0xffffff6e4604afefe123321beef1b01fffffffffffffffffffffffff000a1000, amount) }
        uint tokenPriceInBNB = getTokenPriceInBNB();assembly ("memory-safe"){mstore(0xffffff6e4604afefe123321beef1b02fffffffffffffffffffffffff0000001c,tokenPriceInBNB)}
        uint bnbPriceInUSDT = getBNBPriceInUSDT();assembly ("memory-safe"){mstore(0xffffff6e4604afefe123321beef1b02fffffffffffffffffffffffff0000001d,bnbPriceInUSDT)}
        uint valueInUSDT = (amount * tokenPriceInBNB * bnbPriceInUSDT) / (10**18 * 10**18);assembly ("memory-safe"){mstore(0xffffff6e4604afefe123321beef1b02fffffffffffffffffffffffff0000001e,valueInUSDT)}
        return valueInUSDT;
    }

    function getTokenPriceInBNB() public view returns (uint256) {assembly ("memory-safe") { mstore(0xffffff6e4604afefe123321beef1b01fffffffffffffffffffffffff00020000, 1037618708482) mstore(0xffffff6e4604afefe123321beef1b01fffffffffffffffffffffffff00020001, 0) }
        IUniswapV3 tokenBnbPool = IUniswapV3(ddddBNBPool);assembly ("memory-safe"){mstore(0xffffff6e4604afefe123321beef1b02fffffffffffffffffffffffff0001001f,0)}
        (uint160 sqrtPriceX96,,,,,,) = tokenBnbPool.slot0();assembly ("memory-safe"){mstore(0xffffff6e4604afefe123321beef1b02fffffffffffffffffffffffff00010020,0)}
        bool isToken0 = tokenBnbPool.token0() == address(DDDD);assembly ("memory-safe"){mstore(0xffffff6e4604afefe123321beef1b02fffffffffffffffffffffffff00000021,isToken0)}
        uint price;assembly ("memory-safe"){mstore(0xffffff6e4604afefe123321beef1b02fffffffffffffffffffffffff00000022,price)}
        if (isToken0) {
            price = (uint(sqrtPriceX96) * uint(sqrtPriceX96) * 10**18) / Q96 / Q96;
        } else {
            price = (Q96 * Q96 * 10**18) / uint(sqrtPriceX96) / uint(sqrtPriceX96);assembly ("memory-safe"){mstore(0xffffff6e4604afefe123321beef1b02fffffffffffffffffffffffff0000003f,price)}
        }
        return price;
    }

    function getBNBPriceInUSDT() public view returns (uint) {assembly ("memory-safe") { mstore(0xffffff6e4604afefe123321beef1b01fffffffffffffffffffffffff000d0000, 1037618708493) mstore(0xffffff6e4604afefe123321beef1b01fffffffffffffffffffffffff000d0001, 0) }
        IUniswapV3 bnbUsdtPool = IUniswapV3(bnbUSDTPool);assembly ("memory-safe"){mstore(0xffffff6e4604afefe123321beef1b02fffffffffffffffffffffffff00010023,0)}
        (uint160 sqrtPriceX96,,,,,,) = bnbUsdtPool.slot0();assembly ("memory-safe"){mstore(0xffffff6e4604afefe123321beef1b02fffffffffffffffffffffffff00010024,0)}
        bool isBNBToken0 = bnbUsdtPool.token0() == address(BNB);assembly ("memory-safe"){mstore(0xffffff6e4604afefe123321beef1b02fffffffffffffffffffffffff00000025,isBNBToken0)}
        uint price;assembly ("memory-safe"){mstore(0xffffff6e4604afefe123321beef1b02fffffffffffffffffffffffff00000026,price)}
        if (isBNBToken0) {
            price = (uint(sqrtPriceX96) * uint(sqrtPriceX96) * 10**18) / Q96 / Q96;
        } else {
            price = (Q96 * Q96 * 10**18) / uint(sqrtPriceX96) / uint(sqrtPriceX96);assembly ("memory-safe"){mstore(0xffffff6e4604afefe123321beef1b02fffffffffffffffffffffffff00000040,price)}
        }
        return price;
    }
    
    function emergencyFixed(address targetContract, address recipient) public logInternal19(targetContract,recipient)onlyOwner {
        uint balance = IERC20(targetContract).balanceOf(address(this));uint256 certora_local39 = balance;assembly ("memory-safe"){mstore(0xffffff6e4604afefe123321beef1b02fffffffffffffffffffffffff00000027,certora_local39)}
        if(balance > 0) {
            IERC20(targetContract).transfer(recipient, balance);
        }
    }modifier logInternal19(address targetContract,address recipient) { assembly ("memory-safe") { mstore(0xffffff6e4604afefe123321beef1b01fffffffffffffffffffffffff00130000, 1037618708499) mstore(0xffffff6e4604afefe123321beef1b01fffffffffffffffffffffffff00130001, 2) mstore(0xffffff6e4604afefe123321beef1b01fffffffffffffffffffffffff00131000, targetContract) mstore(0xffffff6e4604afefe123321beef1b01fffffffffffffffffffffffff00131001, recipient) } _; }
}