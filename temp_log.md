TransactionScreen(dirty, state:
_TransactionScreenState#75ead):
'isNegative'
method not found
Receiver: ""
Arguments: []

The relevant error-causing widget was:
  TransactionScreen
  TransactionScreen:file:///F:/School/Undergraduate/7-Seventh/Pemrograman%2
  0Piranti%20Bergerak%20-%20Yusup%20Jauhari%20Shandi,%20M.Kom/Projects/mone
  y_tracker/lib/screens/layout.dart:23:11

When the exception was thrown, this was the stack:
C:/b/s/w/ir/cache/builder/src/out/host_debug/dart-sdk/lib/_internal/js_dev_
runtime/private/ddc_runtime/errors.dart 266:49      throw_
C:/b/s/w/ir/cache/builder/src/out/host_debug/dart-sdk/lib/_internal/js_dev_
runtime/private/ddc_runtime/operations.dart 735:3   defaultNoSuchMethod    
C:/b/s/w/ir/cache/builder/src/out/host_debug/dart-sdk/lib/_internal/js_dev_
runtime/patch/core_patch.dart 61:17                 noSuchMethod
C:/b/s/w/ir/cache/builder/src/out/host_debug/dart-sdk/lib/_internal/js_dev_
runtime/private/ddc_runtime/operations.dart 730:31  noSuchMethod
C:/b/s/w/ir/cache/builder/src/out/host_debug/dart-sdk/lib/_internal/js_dev_
runtime/private/ddc_runtime/operations.dart 120:10  dload
packages/intl/src/intl/number_format.dart 786:30
[_signPrefix]
packages/intl/src/intl/number_format.dart 430:10
format
packages/money_tracker/themes/currency_format.dart 11:29
convertToIdr
packages/money_tracker/screens/transaction_screen.dart 330:3
total
packages/money_tracker/screens/transaction_screen.dart 101:3
screen
packages/money_tracker/screens/transaction_screen.dart 53:3
build

---

Performing hot restart...                                          649ms
Restarted application in 651ms.
══╡ EXCEPTION CAUGHT BY WIDGETS LIBRARY ╞═══════════════════════════════════════════════════════════
The following FormatException was thrown building TransactionScreen(dirty, state:
_TransactionScreenState#ac190):
Invalid double

The relevant error-causing widget was:
  TransactionScreen
  TransactionScreen:file:///F:/School/Undergraduate/7-Seventh/Pemrograman%20Piranti%20Bergerak%20-%20Yusup%20Jauhari%20Sha
  ndi,%20M.Kom/Projects/money_tracker/lib/screens/layout.dart:23:11

When the exception was thrown, this was the stack:
C:/b/s/w/ir/cache/builder/src/out/host_debug/dart-sdk/lib/_internal/js_dev_runtime/private/ddc_runtime/errors.dart 266:49
throw_
C:/b/s/w/ir/cache/builder/src/out/host_debug/dart-sdk/lib/_internal/js_dev_runtime/patch/core_patch.dart 267:5
parse
packages/money_tracker/screens/transaction_screen.dart 330:3
total
packages/money_tracker/screens/transaction_screen.dart 101:3
screen
packages/money_tracker/screens/transaction_screen.dart 53:3
build