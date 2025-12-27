module.exports = {
  root: true,

  env: {
    es6: true,
    node: true,
  },

  parser: "@typescript-eslint/parser",

  parserOptions: {
    project: ["tsconfig.json", "tsconfig.dev.json"],
    sourceType: "module",
  },

  plugins: [
    "@typescript-eslint",
    "import",
  ],

  extends: [
    "eslint:recommended",
    "plugin:import/errors",
    "plugin:import/warnings",
    "plugin:import/typescript",
    "google",
    "plugin:@typescript-eslint/recommended",
  ],

  ignorePatterns: [
    "/lib/**/*",
    "/generated/**/*",
  ],

  rules: {
    /* ============================
       Formatting (strict but sane)
       ============================ */
    "quotes": ["error", "double"],
    "indent": ["error", 2],
    "linebreak-style": ["error", "unix"],

    /* ============================
       Kill Google-style nonsense
       ============================ */
    "require-jsdoc": "off",
    "valid-jsdoc": "off",

    /* ============================
       TypeScript pragmatism
       ============================ */
    "@typescript-eslint/no-non-null-assertion": "warn",
    "@typescript-eslint/no-explicit-any": "warn",

    /* ============================
       Imports
       ============================ */
    "import/no-unresolved": "off",
  },
};
