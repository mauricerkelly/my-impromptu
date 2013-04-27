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

  section 'git:stage',
    content: git._status
    when: git.isRepo
    foreground: 'magenta'
    background: 'white'
    format: (statuses) ->
      staged = _.reduce statuses, (memo, status) ->
        memo += 1 if status.staged
        memo
      , 0

      return "#{staged} staged" if staged

  section 'git:status',
    content: [git.modified, git.deleted, git.added, git.untracked]
    format: (mod, del, add, untracked) ->
      output = []
      output.push "#{mod} changed"   if mod
      output.push "#{del} deleted"   if del
      output.push "#{add} added"     if add
      output.push "#{untracked} new" if untracked

      output.join ' | '
    when: git.isRepo
    foreground: 'green'
    background: 'black'

  section 'git:aheadBehind',
    content: [git.ahead, git.behind]
    background: 'red'
    foreground: 'white'
    when: git.isRepo
    format: (ahead, behind) ->
      outputs = []
      outputs.push "#{ahead} ahead" if ahead
      outputs.push "#{behind} behind" if behind

      outputs.join ' & '

  section 'end',
    content: '\n$'
    foreground: 'blue'
    options:
      newlines: true
