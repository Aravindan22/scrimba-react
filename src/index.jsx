import { createRoot } from "react-dom/client";
const root = createRoot(document.getElementById("root"));
import App from "./App";

function Page() {
  return <App />;
}

root.render(<Page />);
