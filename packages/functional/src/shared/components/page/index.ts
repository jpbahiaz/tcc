import { composeIO } from "react-compose-io";
import { mediumPageIO, pageIO, smallPageIO } from "./io";
import { PageView } from "./view";

export const Page = composeIO(PageView, pageIO);
export const MediumPage = composeIO(PageView, mediumPageIO);
export const SmallPage = composeIO(PageView, smallPageIO);
