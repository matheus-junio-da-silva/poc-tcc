## not-pausable
```
'solc --version' running
'solc @openzeppelin/contracts=node_modules/@openzeppelin/contracts contracts/ABCCApp.sol --combined-json abi,ast,bin,bin-runtime,srcmap,srcmap-runtime,userdoc,devdoc,hashes --via-ir --optimize --allow-paths .,/home/mat/poc1novo/poc-tcc/detasets/DeFiHackLabs/ABCCApp/contracts' running
Traceback (most recent call last):
  File "/home/mat/.local/bin/slither", line 6, in <module>
    sys.exit(main())
             ^^^^^^
  File "/home/mat/.local/lib/python3.12/site-packages/slither/__main__.py", line 760, in main
    main_impl(all_detector_classes=detectors, all_printer_classes=printers)
  File "/home/mat/.local/lib/python3.12/site-packages/slither/__main__.py", line 865, in main_impl
    ) = process_all(filename, args, detector_classes, printer_classes)
        ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
  File "/home/mat/.local/lib/python3.12/site-packages/slither/__main__.py", line 106, in process_all
    ) = process_single(compilation, args, detector_classes, printer_classes)
        ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
  File "/home/mat/.local/lib/python3.12/site-packages/slither/__main__.py", line 86, in process_single
    return _process(slither, detector_classes, printer_classes)
           ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
  File "/home/mat/.local/lib/python3.12/site-packages/slither/__main__.py", line 142, in _process
    printer_results = slither.run_printers()
                      ^^^^^^^^^^^^^^^^^^^^^^
  File "/home/mat/.local/lib/python3.12/site-packages/slither/slither.py", line 297, in run_printers
    return [p.output(self._crytic_compile.target).data for p in self._printers]
            ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
  File "/home/mat/.local/lib/python3.12/site-packages/slither/printers/summary/when_not_paused.py", line 46, in output
    status = "X" if _use_modifier(function, modifier_name) else ""
                    ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
  File "/home/mat/.local/lib/python3.12/site-packages/slither/printers/summary/when_not_paused.py", line 14, in _use_modifier
    if isinstance(ir, function, SolidityFunction):
       ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
TypeError: isinstance expected 2 arguments, got 3
