module Service.Navigate where

import Prelude
import Service.Route (Route)

import Halogen (HalogenM, lift)

class Monad m <= Navigate m where
  navigate :: Route -> m Unit

instance navigateHalogenM :: Navigate m => Navigate ( HalogenM state action slots msg m ) where
  navigate = lift <<< navigate
