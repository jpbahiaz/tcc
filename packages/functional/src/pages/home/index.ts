import { composeIO } from "react-compose-io";
import { homeIO } from "./io";
import { HomeView } from "./view";

export const Home = composeIO(HomeView, homeIO);
