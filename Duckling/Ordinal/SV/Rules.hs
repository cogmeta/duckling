-- Copyright (c) 2016-present, Facebook, Inc.
-- All rights reserved.
--
-- This source code is licensed under the BSD-style license found in the
-- LICENSE file in the root directory of this source tree. An additional grant
-- of patent rights can be found in the PATENTS file in the same directory.


{-# LANGUAGE GADTs #-}
{-# LANGUAGE OverloadedStrings #-}

module Duckling.Ordinal.SV.Rules
  ( rules ) where

import qualified Data.Text as Text
import Prelude
import Data.String

import Duckling.Dimensions.Types
import Duckling.Numeral.Helpers (parseInt)
import Duckling.Ordinal.Helpers
import Duckling.Regex.Types
import Duckling.Types

ruleOrdinalsFirstst :: Rule
ruleOrdinalsFirstst = Rule
  { name = "ordinals (first..31st)"
  , pattern =
    [ regex "(f\x00f6rste|f\x00f6rsta|andra|tredje|fj\x00e4rde|femte|sj\x00e4tte|sjunde|\x00e5ttonde|nionde|tionde|ellevte|tolfte|trettonde|fjortonde|femtonde|sekstende|syttende|attende|nittende|tyvende|tjuende|enogtyvende|toogtyvende|treogtyvende|fireogtyvende|femogtyvende|seksogtyvende|syvogtyvende|\x00e5tteogtyvende|niogtyvende|enogtjuende|toogtjuende|treogtjuende|fireogtjuende|femogtjuende|seksogtjuende|syvogtjuende|\x00e5tteogtyvend|niogtjuende|tredefte|enogtredefte)"
    ]
  , prod = \tokens -> case tokens of
      (Token RegexMatch (GroupMatch (match:_)):_) -> case Text.toLower match of
        "f\x00f6rsta" -> Just $ ordinal 1
        "f\x00f6rste" -> Just $ ordinal 1
        "andra" -> Just $ ordinal 2
        "tredje" -> Just $ ordinal 3
        "fj\x00e4rde" -> Just $ ordinal 4
        "femte" -> Just $ ordinal 5
        "sj\x00e4tte" -> Just $ ordinal 6
        "sjunde" -> Just $ ordinal 7
        "\x00e5ttonde" -> Just $ ordinal 8
        "nionde" -> Just $ ordinal 9
        "tionde" -> Just $ ordinal 10
        "ellevte" -> Just $ ordinal 11
        "tolfte" -> Just $ ordinal 12
        "trettonde" -> Just $ ordinal 13
        "fjortonde" -> Just $ ordinal 14
        "femtonde" -> Just $ ordinal 15
        "sekstende" -> Just $ ordinal 16
        "syttende" -> Just $ ordinal 17
        "attende" -> Just $ ordinal 18
        "nittende" -> Just $ ordinal 19
        "tyvende" -> Just $ ordinal 20
        "tjuende" -> Just $ ordinal 20
        "enogtjuende" -> Just $ ordinal 21
        "enogtyvende" -> Just $ ordinal 21
        "toogtyvende" -> Just $ ordinal 22
        "toogtjuende" -> Just $ ordinal 22
        "treogtyvende" -> Just $ ordinal 23
        "treogtjuende" -> Just $ ordinal 23
        "fireogtjuende" -> Just $ ordinal 24
        "fireogtyvende" -> Just $ ordinal 24
        "femogtyvende" -> Just $ ordinal 25
        "femogtjuende" -> Just $ ordinal 25
        "seksogtjuende" -> Just $ ordinal 26
        "seksogtyvende" -> Just $ ordinal 26
        "syvogtyvende" -> Just $ ordinal 27
        "syvogtjuende" -> Just $ ordinal 27
        "\x00e5tteogtyvende" -> Just $ ordinal 28
        "\x00e5tteogtjuende" -> Just $ ordinal 28
        "niogtyvende" -> Just $ ordinal 29
        "niogtjuende" -> Just $ ordinal 29
        "tredefte" -> Just $ ordinal 30
        "enogtredefte" -> Just $ ordinal 31
        _ -> Nothing
      _ -> Nothing
  }

ruleOrdinalDigits :: Rule
ruleOrdinalDigits = Rule
  { name = "ordinal (digits)"
  , pattern =
    [ regex "0*(\\d+)(\\.|e|\\:[ae])?"
    ]
  , prod = \tokens -> case tokens of
      (Token RegexMatch (GroupMatch (match:_)):_) -> ordinal <$> parseInt match
      _ -> Nothing
  }

rules :: [Rule]
rules =
  [ ruleOrdinalDigits
  , ruleOrdinalsFirstst
  ]
