import Joi from "joi";

interface UserRegistrationData {
  first_name: string;
  last_name: string;

  email: string;
  password: string;
}
const userRegisterSchema: Joi.ObjectSchema = Joi.object({
  email: Joi.string().email().required(),
  first_name: Joi.string().required(),
  last_name: Joi.string().required(),
  password: Joi.string().required(),
});

export { userRegisterSchema, UserRegistrationData };
