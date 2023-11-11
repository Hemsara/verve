import bcrypt from 'bcryptjs';


// Hash a password
export function hashPassword(plainPassword: string): Promise<string> {
  return new Promise<string>((resolve, reject) => {
    bcrypt.genSalt(10, (err: Error | null, salt: string) => {
      if (err) {
        reject(err);
      } else {
        bcrypt.hash(plainPassword, salt, (err: Error | null, hash: string) => {
          if (err) {
            reject(err);
          } else {
            resolve(hash);
          }
        });
      }
    });
  });
}

// Verify a password
export function verifyPassword(
  plainPassword: string,
  hashedPassword: string
): Promise<boolean> {
  return new Promise<boolean>((resolve, reject) => {
    bcrypt.compare(
      plainPassword,
      hashedPassword,
      (err: Error | null, result: boolean) => {
        if (err) {
          reject(err);
        } else {
          resolve(result);
        }
      }
    );
  });
}
