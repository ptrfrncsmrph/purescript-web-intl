# `web-intl`

Low-level bindings for the ECMA 402 specification for the `Intl` object https://tc39.es/ecma402/#intl-object

## How to use this library

Assuming these imports

```purs
import Data.Array as Array
import Data.Array.NonEmpty as NonEmpty
import Data.JSDate as JSDate
import Effect.Class.Console as Console
import Web.Intl.Collator as Collator
import Web.Intl.DateTimeFormat as DateTimeFormat
import Web.Intl.Locale as Locale
import Web.Intl.NumberFormat as NumberFormat
```

we can construct a `Locale` using the `new` or `new_` constructors.

```purs
main = do
  en_US <- Locale.new "en-US" { hourCycle: "h24" }
  es_MX <- Locale.new_ "es-MX"
```

All service constructors take a non-empty array of locales as first argument.

```purs
  let locales = NonEmpty.cons' en_US [ es_MX ]
```

Now we can use the `Collator` module to sort a collection of strings by [natural sort order](https://en.wikipedia.org/wiki/Natural_sort_order),

```purs
  collator <- Collator.new locales { numeric: true }
  let
    sortedStrings = Array.sortBy (Collator.compare collator) [ "Chapter 1", "Chapter 11", "Chapter 2" ]
  Console.logShow sortedStrings -- [ "Chapter 1", "Chapter 2", "Chapter 11" ]
```

or we can format a date using `DateTimeFormat`,

```purs
  dateTimeFormat <- DateTimeFormat.new locales { dateStyle: "full", timeZone: "UTC" }
  let
    formattedDate = DateTimeFormat.format dateTimeFormat (JSDate.fromTime 0.0)
  Console.logShow formattedDate -- "Thursday, January 1, 1970"
```

or use `NumberFormat` for formatting currencies for example.

```purs
  numberFormat <- NumberFormat.new locales { style: "currency", currency: "USD" }
  let
    formattedNumber = NumberFormat.format numberFormat 123456.789
  Console.logShow formattedNumber -- "$123,456.79"
```

More examples are in the `Test.Main` module.
