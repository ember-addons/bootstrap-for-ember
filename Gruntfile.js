// Generated on 2013-08-24 using generator-webapp 0.2.6
'use strict';
var LIVERELOAD_PORT = 35729;
var lrSnippet = require('connect-livereload')({port: LIVERELOAD_PORT});
var mountFolder = function (connect, dir) {
    return connect.static(require('path').resolve(dir));
};

// # Globbing
// for performance reasons we're only matching one level down:
// 'test/spec/{,*/}*.js'
// use this if you want to recursively match all subfolders:
// 'test/spec/**/*.js'

module.exports = function (grunt) {
    // load all grunt tasks
    require('matchdep').filterDev('grunt-*').forEach(grunt.loadNpmTasks);

    // configurable paths
    var yeomanConfig = {
        app: 'app',
        dist: 'dist'
    };

    grunt.initConfig({
        yeoman: yeomanConfig,
        watch: {
            coffee: {
                files: ['<%= yeoman.app %>/scripts/**/*.coffee'],
                tasks: ['coffee:dist','neuter']
            },
            coffeeTest: {
                files: ['test/spec/{,*/}*.coffee'],
                tasks: ['coffee:test']
            },
            compass: {
                files: ['<%= yeoman.app %>/styles/{,*/}*.{scss,sass}'],
                tasks: ['compass:server']
            },
            ember_handlebars: {
                files: '<%= yeoman.app %>/templates/**/*.hbs',
                tasks: ['ember_handlebars']
            },
            markdown: {
                files: '<%= yeoman.app %>/templates/**/*.md',
                tasks: ['markdown']
            },
            livereload: {
                options: {
                    livereload: LIVERELOAD_PORT
                },
                files: [
                    '<%= yeoman.app %>/*.html',
                    '{.tmp,<%= yeoman.app %>}/styles/{,*/}*.css',
                    '{.tmp,<%= yeoman.app %>}/scripts/{,*/}*.js',
                    '<%= yeoman.app %>/images/{,*/}*.{png,jpg,jpeg,gif,webp,svg}'
                ]
            }
            /*
            neuter: {
                files: [
                    '<%= yeoman.app %>/scripts/showcase.coffee',
                    '<%= yeoman.app %>/scripts/showcase/***.coffee',
                ],
                tasks: ['neuter']
            }*/
        },
        connect: {
            options: {
                port: 9000,
                // change this to '0.0.0.0' to access the server from outside
                hostname: 'localhost'
            },
            livereload: {
                options: {
                    middleware: function (connect) {
                        return [
                            lrSnippet,
                            mountFolder(connect, '.tmp'),
                            mountFolder(connect, yeomanConfig.app)
                        ];
                    }
                }
            },
            test: {
                options: {
                    middleware: function (connect) {
                        return [
                            mountFolder(connect, '.tmp'),
                            mountFolder(connect, 'test')
                        ];
                    }
                }
            },
            dist: {
                options: {
                    middleware: function (connect) {
                        return [
                            mountFolder(connect, yeomanConfig.dist)
                        ];
                    }
                }
            }
        },
        open: {
            server: {
                path: 'http://localhost:<%= connect.options.port %>'
            }
        },
        clean: {
            dist: {
                files: [{
                    dot: true,
                    src: [
                        '.tmp',
                        '<%= yeoman.dist %>/*',
                        '!<%= yeoman.dist %>/.git*'
                    ]
                }]
            },
            server: '.tmp'
        },
        jshint: {
            options: {
                jshintrc: '.jshintrc'
            },
            all: [
                'Gruntfile.js',
                '<%= yeoman.app %>/scripts/{,*/}*.js',
                '!<%= yeoman.app %>/scripts/vendor/*',
                'test/spec/{,*/}*.js'
            ]
        },
        mocha: {
            all: {
                options: {
                    run: true,
                    urls: ['http://localhost:<%= connect.options.port %>/index.html']
                }
            }
        },
        coffee: {
            dist: {
                files: [{
                    expand: true,
                    cwd: '<%= yeoman.app %>/scripts',
                    src: '**/*.coffee',
                    dest: '.tmp/scripts',
                    ext: '.js'
                }]
            },
            test: {
                files: [{
                    expand: true,
                    cwd: 'test/spec',
                    src: '{,*/}*.coffee',
                    dest: '.tmp/spec',
                    ext: '.js'
                }]
            }
        },
        compass: {
            options: {
                sassDir: '<%= yeoman.app %>/styles',
                cssDir: '.tmp/styles',
                generatedImagesDir: '.tmp/images/generated',
                imagesDir: '<%= yeoman.app %>/images',
                javascriptsDir: '<%= yeoman.app %>/scripts',
                fontsDir: '<%= yeoman.app %>/styles/fonts',
                importPath: '<%= yeoman.app %>/bower_components',
                httpImagesPath: '/images',
                httpGeneratedImagesPath: '/images/generated',
                httpFontsPath: '/styles/fonts',
                relativeAssets: false
            },
            dist: {},
            server: {
                options: {
                    debugInfo: true
                }
            }
        },
        // not used since Uglify task does concat,
        // but still available if needed
        /*concat: {
            dist: {}
        },*/
        // not enabled since usemin task does concat and uglify
        // check index.html to edit your build targets
        // enable this task if you prefer defining your build targets here
        /*uglify: {
            dist: {}
        },*/
        rev: {
            dist: {
                files: {
                    src: [
                        '<%= yeoman.dist %>/scripts/{,*/}*.js',
                        '<%= yeoman.dist %>/styles/{,*/}*.css',
                        '<%= yeoman.dist %>/images/{,*/}*.{png,jpg,jpeg,gif,webp}',
                        '<%= yeoman.dist %>/styles/fonts/*'
                    ]
                }
            }
        },
        useminPrepare: {
            options: {
                dest: '<%= yeoman.dist %>'
            },
            html: '<%= yeoman.app %>/index.html'
        },
        usemin: {
            options: {
                dirs: ['<%= yeoman.dist %>']
            },
            html: ['<%= yeoman.dist %>/{,*/}*.html'],
            css: ['<%= yeoman.dist %>/styles/{,*/}*.css']
        },
        imagemin: {
            dist: {
                files: [{
                    expand: true,
                    cwd: '<%= yeoman.app %>/images',
                    src: '{,*/}*.{png,jpg,jpeg}',
                    dest: '<%= yeoman.dist %>/images'
                }]
            }
        },
        svgmin: {
            dist: {
                files: [{
                    expand: true,
                    cwd: '<%= yeoman.app %>/images',
                    src: '{,*/}*.svg',
                    dest: '<%= yeoman.dist %>/images'
                }]
            }
        },
        cssmin: {
            // This task is pre-configured if you do not wish to use Usemin
            // blocks for your CSS. By default, the Usemin block from your
            // `index.html` will take care of minification, e.g.
            //
            //     <!-- build:css({.tmp,app}) styles/main.css -->
            //
            // dist: {
            //     files: {
            //         '<%= yeoman.dist %>/styles/main.css': [
            //             '.tmp/styles/{,*/}*.css',
            //             '<%= yeoman.app %>/styles/{,*/}*.css'
            //         ]
            //     }
            // }
        },
        htmlmin: {
            dist: {
                options: {
                    /*removeCommentsFromCDATA: true,
                    // https://github.com/yeoman/grunt-usemin/issues/44
                    //collapseWhitespace: true,
                    collapseBooleanAttributes: true,
                    removeAttributeQuotes: true,
                    removeRedundantAttributes: true,
                    useShortDoctype: true,
                    removeEmptyAttributes: true,
                    removeOptionalTags: true*/
                },
                files: [{
                    expand: true,
                    cwd: '<%= yeoman.app %>',
                    src: '*.html',
                    dest: '<%= yeoman.dist %>'
                }]
            }
        },
        // Put files not handled in other tasks here
        copy: {
            dist: {
                files: [{
                    expand: true,
                    dot: true,
                    cwd: '<%= yeoman.app %>',
                    dest: '<%= yeoman.dist %>',
                    src: [
                        '*.{ico,png,txt}',
                        '.htaccess',
                        'images/{,*/}*.{webp,gif}',
                        'styles/fonts/*'
                    ]
                }, {
                    expand: true,
                    cwd: '.tmp/images',
                    dest: '<%= yeoman.dist %>/images',
                    src: [
                        'generated/*'
                    ]
                }]
            },
            //Copy unminified files before the uglify runs
            unminified: {
                files: [{
                    expand: true,
                    src: ['<%= yeoman.dist %>/js/bs-*.min.js'],
                    ext: '.max.js'
                }]
            }
        },
        concurrent: {
            server: [
                'compass',
                'markdown',
                'ember_handlebars',
                'coffee:dist'
            ],
            test: [
                'coffee'
            ],
            dist: [
                'coffee',
                'markdown',
                'ember_handlebars',
                'compass',
                'imagemin',
                'svgmin',
                'htmlmin'
            ]
        },
        ember_handlebars: {
            compile_components: {
                options: {
                    processName: function(filename) {
                        var fromComponent = filename.substring(filename.lastIndexOf('/components/')+1,filename.length);
                        return fromComponent.substring(0,fromComponent.length-4);
                    },
                    namespace: "Ember.TEMPLATES"
                },
                files: {
                    '.tmp/scripts/bs-basic.js': [
                        '<%= yeoman.app %>/templates/components/bs-page-header.hbs',
                        '<%= yeoman.app %>/templates/components/bs-well.hbs',
                        '<%= yeoman.app %>/templates/components/bs-panel.hbs',
                    ],
                    '.tmp/scripts/bs-alert.js': '<%= yeoman.app %>/templates/components/bs-alert.hbs',
                    '.tmp/scripts/bs-label.js': '<%= yeoman.app %>/templates/components/bs-label.hbs',
                    '.tmp/scripts/bs-badge.js': '<%= yeoman.app %>/templates/components/bs-badge.hbs',
                    '.tmp/scripts/bs-button.js': '<%= yeoman.app %>/templates/components/bs-button.hbs',
                    '.tmp/scripts/bs-btn-toolbar.js': '<%= yeoman.app %>/templates/components/bs-btn-toolbar.hbs',
                    '.tmp/scripts/bs-progressbar.js': [
                        '<%= yeoman.app %>/templates/components/bs-progress.hbs',
                        '<%= yeoman.app %>/templates/components/bs-progressbar.hbs'
                        ],
                    '.tmp/scripts/bs-pills.js': '<%= yeoman.app %>/templates/components/bs-pills.hbs',
                    '.tmp/scripts/bs-modal.js': '<%= yeoman.app %>/templates/components/bs-modal.hbs'
                }
            },
            compile_showcase: {
                options: {
                    processName: function(filename) {
                        var fromShowcase = filename.substring(filename.lastIndexOf('/showcase/')+1,filename.length)
                        return fromShowcase.substring(fromShowcase.indexOf('/')+1,fromShowcase.length-4);
                    },
                    namespace: "Ember.TEMPLATES"
                },
                files: {
                    '.tmp/scripts/showcase-templates.js': '<%= yeoman.app %>/templates/showcase/**/*.hbs'
                }
            }
        },
        markdown: {
            all: {
                files: [
                    {
                        expand: true,
                        src: '<%= yeoman.app %>/templates/showcase/show_components/*.md',
                        dest: '',
                        ext: '.hbs'
                    }
                ],
                options: {
                    template: '<%= yeoman.app %>/templates/showcase/show_components/template.jst',
                    postCompile: function(src, context) {
                        src = src.replace(/\\{\\{/g,"&#123;&#123;");
                        src = src.replace(/\\}\\}/g,"&#125;&#125;");
                        src = src.replace(/\&quot\;/g,'"');

                        console.log(src);

                        return src;
                    },
                    markdownOptions: {
                        gfm: true,
                        codeLines: {
                            before: '<span>',
                            after: '</span>'
                        }

                    }
                }
            }
        },
        neuter: {
            showcase: {
                options: {
                    //The .tmp folder / 'path specified in the require', i.e: 'require('scripts/showcase/router') becomes
                    //'.tmp/scripts/showcase/router
                    filepathTransform: function (filepath) {
                        return '.tmp/' + filepath;
                    }
                },
                //src: '<%= yeoman.app/scripts/showcase.js',
                src: '.tmp/scripts/showcase.js',
                dest: '.tmp/scripts/showcase-scripts.js'
            }
        }
    });

    grunt.registerTask('server', function (target) {
        if (target === 'dist') {
            return grunt.task.run(['build', 'open', 'connect:dist:keepalive']);
        }

        grunt.task.run([
            'clean:server',
            'concurrent:server',
            'neuter:showcase',
            'connect:livereload',
            //'open',
            'watch'
        ]);
    });

    grunt.registerTask('test', [
        'clean:server',
        'concurrent:test',
        'connect:test',
        //'mocha'
    ]);

    grunt.registerTask('build', [
        'clean:dist',
        'useminPrepare',
        'concurrent:dist',
        'neuter',
        'concat',
        'copy:unminified',
        'cssmin',
        'uglify',
        'copy:dist',
        'rev',
        'usemin'
    ]);

    grunt.registerTask('default', [
        //'jshint',
        'test',
        'build'
    ]);
};
