import Joi from "joi";

interface UserLoginData {

  email: string;
  password: string;
}
const userLoginSchema: Joi.ObjectSchema = Joi.object({
  email: Joi.string().email().required(),
  password: Joi.string().required(),
});

export { userLoginSchema, UserLoginData };
