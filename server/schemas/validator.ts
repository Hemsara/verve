import { Request, Response, NextFunction } from "express";
import Joi from 'joi';

type ValidationSchema = Joi.ObjectSchema<any>; // You can adjust the schema type as needed

const validateSchema = (schema: ValidationSchema) => {
  return (req: Request, res: Response, next: NextFunction) => {

    const { error } = schema.validate(req.body);
    if (error) {
      return res.status(400).json({ error: error.details[0].message });
    }
    next(); // If validation passes, continue to the next middleware or route handler.
  };
};

export default validateSchema;
