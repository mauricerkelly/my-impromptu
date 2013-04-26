module.exports = (Impromptu, section) ->
  system = Impromptu.module.require 'impromptu-system'
  git = Impromptu.module.require 'impromptu-git'

  section 'user',
    content: [system.user, system.shortHost]
    format: (user, host) ->
      return if user.trim() is process.env.DEFAULT_USER
      "#{user}@#{host}"
    background: 'black'

  section 'pwd',
    content: system.prettyPwd
    background: 'blue'
    foreground: 'black'

  section 'git:in',
    when: git.branch
    content: 'in'
    background: 'black'

  section 'git:branch',
    content: git.branch
    background: 'green'
    foreground: 'black'

  section 'git:status',
    when: git.status
    content: [git.untracked, git.modified, git.deleted]
    format: (untracked, modified, deleted) ->
      "(#{untracked}/#{modified}/#{deleted})"
    background: 'green'
    foreground: 'white'

  section 'end',
    content: '\n$'
    foreground: 'blue'
    options:
      newlines: true
