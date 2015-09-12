module.exports = (grunt) ->

  grunt.initConfig
    coffee:
      options:
        bare: true
      index:
        files: [
          expand: true
          cwd: "./"
          src: ["index.coffee"]
          dest: "./"
          ext: ".js"
        ]
      compile:
        files: [
          expand: true
          cwd: "./lib"
          src: ["**/*.coffee"]
          dest: "./lib"
          ext: ".js"
        ]


    mochaTest:
      test:
        options:
          ui: 'bdd'
          reporter: 'spec'
          require: ['coffee-script', './test/support/globals.js']
          slow: '1ms'

        src: ['test/unit/**/*.coffee']

    watch:
      tests:
        files: ['test/**/*.coffee', 'lib/**/*.coffee']
        tasks: ['test']


  grunt.loadNpmTasks('grunt-mocha-test')
  grunt.loadNpmTasks('grunt-contrib-coffee')
  grunt.loadNpmTasks('grunt-contrib-watch')

  grunt.registerTask('test', ['default', 'mochaTest'])
  grunt.registerTask('test:watch', ['test', 'watch'])
  grunt.registerTask('default', ['coffee'])

