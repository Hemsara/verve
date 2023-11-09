import Joi from "joi";

interface UserRegistrationData {
  name: string;
  email: string;
  password: string;
}
const userRegisterSchema: Joi.ObjectSchema = Joi.object({
  email: Joi.string().email().required(),
  name: Joi.string().required(),
  password: Joi.string().required(),
});

export { userRegisterSchema, UserRegistrationData };
