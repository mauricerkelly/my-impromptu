
module.exports = (Impromptu, section) ->
  system = @module.require 'impromptu-system'
  git = @module.require 'impromptu-git'

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

  section 'git:staged',
    content: git.staged
    format: (staged) ->
      "staged #{staged}" if staged
    when: git.isRepo
    foreground: 'green'

  section 'git:unstaged',
    content: git.unstaged
    format: (unstaged) ->
      "unstaged #{unstaged}" if unstaged
    when: git.isRepo
    foreground: 'blue'

  section 'git:ahead',
    content: git.ahead
    background: 'green'
    foreground: 'white'
    when: git.isRepo
    format: (ahead) ->
      "#{ahead} ahead" if ahead

  section 'git:behind',
    content: git.behind
    background: 'red'
    foreground: 'white'
    when: git.isRepo
    format: (behind) ->
      "#{behind} behind" if behind

  section 'end',
    content: '\n$'
    foreground: 'blue'
    options:
      newlines: true
