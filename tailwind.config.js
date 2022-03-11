module.exports = {
    content: ["./src/**/*.{html,js,ts,elm}"],
    theme: {
        extend: {},
    },
    plugins: [
        require('@tailwindcss/line-clamp'),
    ],
}
