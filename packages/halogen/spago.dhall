{ name = "halogen-project"
, dependencies =
  [ "aff"
  , "arrays"
  , "console"
  , "css"
  , "effect"
  , "either"
  , "halogen"
  , "halogen-css"
  , "halogen-store"
  , "integers"
  , "maybe"
  , "ordered-collections"
  , "prelude"
  , "psci-support"
  , "routing"
  , "routing-duplex"
  , "safe-coerce"
  , "strings"
  , "tuples"
  , "web-events"
  , "web-html"
  , "web-uievents"
  ]
, packages = ./packages.dhall
, sources = [ "src/**/*.purs", "test/**/*.purs" ]
}
