
module.exports = {
    parser: '@typescript-eslint/parser',
    plugins: ['prettier', '@typescript-eslint', 'react'],
    extends: [
        'react-app',
        'plugin:prettier/recommended'
    ],
    rules: {
        "camelcase": 0,
        "comma-dangle": ["error", "never"],
        "eol-last": ["error", "always"],
        "import/order": [
            "error",
            {
                "groups": ["builtin", "external", "internal", "parent", "sibling", "index"],
                "newlines-between": "always",
                "alphabetize": {
                    "order": "asc",
                    "caseInsensitive": true
                }
            }
        ],
        "indent": ["error", 4],
        "keyword-spacing": [
            "error",
            {
                "after": true,
                "before": true
            }
        ],
        "linebreak-style": [
            "error",
            "unix"
        ],
        "quotes": [
            "error",
            "double",
            {
                "avoidEscape": true,
                "allowTemplateLiterals": true
            }
        ],
        "quote-props": ["error", "consistent"],
        "react/no-unescaped-entities": 0,
        "react-hooks/rules-of-hooks": "error",
        "react-hooks/exhaustive-deps": "warn",
        "semi": [
            "error",
            "always"
        ],
        "space-before-function-paren": [
            "error", {
                "anonymous": "always",
                "asyncArrow": "always",
                "named": "never"
            }
        ]
    },
    settings: {
        "import/resolver": {
            webpack: {
                config: "./webpack.config.js"
            }
        },
        "react": {
            "version": "detect"
        }
    }
};
