import { ButtonProps } from "./Button.view";

export function buttonIO(props: ButtonProps) {
  return {
    onClick: () => {
      props.onClick();
      console.log("button click");
    },
  };
}

export type ButtonIO = ReturnType<typeof buttonIO>;
