module Web.Intl.PluralRules
  -- * Types
  ( PluralRules
  , PluralRulesOptions

  -- * Constructor
  , new
  , new_

  -- * Methods
  , supportedLocalesOf
  , supportedLocalesOf_
  , select
  , selectRange
  , resolvedOptions
  ) where

import Data.Function.Uncurried (Fn2, Fn3)
import Data.Function.Uncurried as Function.Uncurried
import Effect (Effect)
import Effect.Uncurried (EffectFn1, EffectFn2)
import Effect.Uncurried as Effect.Uncurried
import Prim.Row (class Union)
import Unsafe.Coerce as Unsafe.Coerce
import Web.Intl.LocaleOptions (LocaleOptions)

type PluralRulesOptions =
  ( localeMatcher :: String
  , type :: String
  , minimumIntegerDigits :: Int
  , minimumFractionDigits :: Int
  , maximumFractionDigits :: Int
  , minimumSignificantDigits :: Int
  , maximumSignificantDigits :: Int
  )

foreign import data PluralRules :: Type

foreign import _new
  :: EffectFn2
       (Array String)
       (Record PluralRulesOptions)
       PluralRules

new
  :: forall options options'
   . Union options options' PluralRulesOptions
  => Array String
  -> Record options
  -> Effect PluralRules
new locales options =
  Effect.Uncurried.runEffectFn2 _new locales (Unsafe.Coerce.unsafeCoerce options)

new_ :: Array String -> Effect PluralRules
new_ locales =
  new locales {}

foreign import _supportedLocalesOf
  :: Fn2
       (Array String)
       (Record LocaleOptions)
       (Array String)

supportedLocalesOf
  :: forall options options'
   . Union options options' LocaleOptions
  => Array String
  -> Record options
  -> Array String
supportedLocalesOf locales options =
  Function.Uncurried.runFn2 _supportedLocalesOf locales (Unsafe.Coerce.unsafeCoerce options)

supportedLocalesOf_ :: Array String -> Array String
supportedLocalesOf_ locales =
  supportedLocalesOf locales {}

foreign import _select
  :: Fn2
       PluralRules
       Int
       String

select :: PluralRules -> Int -> String
select =
  Function.Uncurried.runFn2 _select

foreign import _selectRange
  :: Fn3
       PluralRules
       Int
       Int
       String

selectRange :: PluralRules -> Int -> Int -> String
selectRange =
  Function.Uncurried.runFn3 _selectRange

type ResolvedOptions =
  { locale :: String
  , type :: String
  , pluralCategories :: Array String
  }

foreign import _resolvedOptions
  :: EffectFn1
       PluralRules
       ResolvedOptions

resolvedOptions :: PluralRules -> Effect ResolvedOptions
resolvedOptions = Effect.Uncurried.runEffectFn1 _resolvedOptions