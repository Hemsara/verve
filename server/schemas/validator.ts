import { Request, Response, NextFunction } from "express";
import Joi from 'joi';

type ValidationSchema = Joi.ObjectSchema<any>; 

const validateSchema = (schema: ValidationSchema) => {
  return (req: Request, res: Response, next: NextFunction) => {

    const { error } = schema.validate(req.body);
    if (error) {
      return res.status(400).json({ error: error.details[0].message });
    }
    next(); 
  };
};

export default validateSchema;
