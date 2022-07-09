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
  , "maybe"
  , "prelude"
  , "psci-support"
  , "routing"
  , "routing-duplex"
  , "web-events"
  , "web-html"
  , "web-uievents"
  ]
, packages = ./packages.dhall
, sources = [ "src/**/*.purs", "test/**/*.purs" ]
}
