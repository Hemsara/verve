
import express, { Express, Request, Response, NextFunction } from "express";
import cookieParser from "cookie-parser";
import routes from "./router.js";

const app: Express = express();
const port: number = 3000;

app.use(express.json());
app.use(express.urlencoded({ extended: false }));
app.use(cookieParser());

app.use(routes);

// 404 error
app.use((res: Response) => {
  res.status(404).json({ error: `Route not found` });
});

app.listen(port, () => {
  console.log(`🔥 App listening on port ${port}`);
});
