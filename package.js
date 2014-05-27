
Package.describe({
  summary: "Xue UI is a web interface for Xue, a priority job queue for Meteor"
});

Package.on_use(function (api, where) {
  api.use(['jade', 'stylus', 'moment', 'templating', 'session'], 'client');
  api.use(['xue', 'coffeescript'], ['client', 'server']);
  api.add_files([
    'views/filter.jade',
    'views/job.jade',
    'views/list.jade',
    'views/menu.jade',
    'views/search.jade',
    'views/sort.jade',
    'views/progress.jade',
    'views/index.jade',

    'src/loading.js',
    'src/progress.js',

    'src/session.coffee',
    'src/job.coffee',
    'src/list.coffee',
    'src/sort.coffee',
    'src/menu.coffee',

    'styles/actions.import.styl',
    'styles/config.import.styl',
    'styles/context-menu.import.styl',
    'styles/error.import.styl',
    'styles/job.import.styl',
    'styles/menu.import.styl',
    'styles/mixins.import.styl',
    'styles/scrollbar.import.styl',
    'styles/main.styl'
  ], 'client');
  api.add_files(['src/methods.coffee'], 'server');
  api.export('XueUISession')
});
