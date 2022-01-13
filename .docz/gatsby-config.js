const { mergeWith } = require('docz-utils')
const fs = require('fs-extra')

let custom = {}
const hasGatsbyConfig = fs.existsSync('./gatsby-config.custom.js')

if (hasGatsbyConfig) {
  try {
    custom = require('./gatsby-config.custom')
  } catch (err) {
    console.error(
      `Failed to load your gatsby-config.js file : `,
      JSON.stringify(err),
    )
  }
}

const config = {
  pathPrefix: '/docz',

  siteMetadata: {
    title: 'My Doc',
    description: 'My awesome app using docz',
  },
  plugins: [
    {
      resolve: 'gatsby-theme-docz',
      options: {
        themeConfig: {},
        src: './',
        gatsbyRoot: null,
        themesDir: 'src',
        mdxExtensions: ['.md', '.mdx'],
        docgenConfig: {},
        menu: [],
        mdPlugins: [],
        hastPlugins: [],
        ignore: ['README.md', './tools/'],
        typescript: false,
        ts: false,
        propsParser: true,
        'props-parser': true,
        debug: false,
        native: false,
        openBrowser: null,
        o: null,
        open: null,
        'open-browser': null,
        root: 'C:\\Users\\daute\\source\\repos\\AdminTools\\.docz',
        base: '/docz',
        source: './',
        'gatsby-root': null,
        files: '**/*.{md,markdown,mdx}',
        public: '/public',
        dest: '.docz/dist',
        d: '.docz/dist',
        editBranch: 'master',
        eb: 'master',
        'edit-branch': 'master',
        config: '',
        title: 'My Doc',
        description: 'My awesome app using docz',
        host: 'localhost',
        port: 3000,
        p: 3000,
        separator: '-',
        paths: {
          root: 'C:\\Users\\daute\\source\\repos\\AdminTools',
          templates:
            'C:\\Users\\daute\\source\\repos\\AdminTools\\node_modules\\docz-core\\dist\\templates',
          docz: 'C:\\Users\\daute\\source\\repos\\AdminTools\\.docz',
          cache: 'C:\\Users\\daute\\source\\repos\\AdminTools\\.docz\\.cache',
          app: 'C:\\Users\\daute\\source\\repos\\AdminTools\\.docz\\app',
          appPackageJson:
            'C:\\Users\\daute\\source\\repos\\AdminTools\\package.json',
          appTsConfig:
            'C:\\Users\\daute\\source\\repos\\AdminTools\\tsconfig.json',
          gatsbyConfig:
            'C:\\Users\\daute\\source\\repos\\AdminTools\\gatsby-config.js',
          gatsbyBrowser:
            'C:\\Users\\daute\\source\\repos\\AdminTools\\gatsby-browser.js',
          gatsbyNode:
            'C:\\Users\\daute\\source\\repos\\AdminTools\\gatsby-node.js',
          gatsbySSR:
            'C:\\Users\\daute\\source\\repos\\AdminTools\\gatsby-ssr.js',
          importsJs:
            'C:\\Users\\daute\\source\\repos\\AdminTools\\.docz\\app\\imports.js',
          rootJs:
            'C:\\Users\\daute\\source\\repos\\AdminTools\\.docz\\app\\root.jsx',
          indexJs:
            'C:\\Users\\daute\\source\\repos\\AdminTools\\.docz\\app\\index.jsx',
          indexHtml:
            'C:\\Users\\daute\\source\\repos\\AdminTools\\.docz\\app\\index.html',
          db:
            'C:\\Users\\daute\\source\\repos\\AdminTools\\.docz\\app\\db.json',
        },
      },
    },
  ],
}

const merge = mergeWith((objValue, srcValue) => {
  if (Array.isArray(objValue)) {
    return objValue.concat(srcValue)
  }
})

module.exports = merge(config, custom)
