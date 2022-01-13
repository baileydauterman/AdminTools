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
    title: 'Docs',
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
        ignore: [],
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
        root: 'C:\\Users\\daute\\source\\repos\\AdminTools\\docs\\.docz',
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
        title: 'Docs',
        description: 'My awesome app using docz',
        host: 'localhost',
        port: 3000,
        p: 3000,
        separator: '-',
        paths: {
          root: 'C:\\Users\\daute\\source\\repos\\AdminTools\\docs',
          templates:
            'C:\\Users\\daute\\source\\repos\\AdminTools\\docs\\node_modules\\docz-core\\dist\\templates',
          docz: 'C:\\Users\\daute\\source\\repos\\AdminTools\\docs\\.docz',
          cache:
            'C:\\Users\\daute\\source\\repos\\AdminTools\\docs\\.docz\\.cache',
          app: 'C:\\Users\\daute\\source\\repos\\AdminTools\\docs\\.docz\\app',
          appPackageJson:
            'C:\\Users\\daute\\source\\repos\\AdminTools\\docs\\package.json',
          appTsConfig:
            'C:\\Users\\daute\\source\\repos\\AdminTools\\docs\\tsconfig.json',
          gatsbyConfig:
            'C:\\Users\\daute\\source\\repos\\AdminTools\\docs\\gatsby-config.js',
          gatsbyBrowser:
            'C:\\Users\\daute\\source\\repos\\AdminTools\\docs\\gatsby-browser.js',
          gatsbyNode:
            'C:\\Users\\daute\\source\\repos\\AdminTools\\docs\\gatsby-node.js',
          gatsbySSR:
            'C:\\Users\\daute\\source\\repos\\AdminTools\\docs\\gatsby-ssr.js',
          importsJs:
            'C:\\Users\\daute\\source\\repos\\AdminTools\\docs\\.docz\\app\\imports.js',
          rootJs:
            'C:\\Users\\daute\\source\\repos\\AdminTools\\docs\\.docz\\app\\root.jsx',
          indexJs:
            'C:\\Users\\daute\\source\\repos\\AdminTools\\docs\\.docz\\app\\index.jsx',
          indexHtml:
            'C:\\Users\\daute\\source\\repos\\AdminTools\\docs\\.docz\\app\\index.html',
          db:
            'C:\\Users\\daute\\source\\repos\\AdminTools\\docs\\.docz\\app\\db.json',
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
