# BitbucketPr

Gem is useful to submit pull-requests to Attlasian Bitbucket through CLI command __if you don't like to open new browser tab__

![](http://www.quickmeme.com/img/78/7802c0254fca6dc4b3ee20300007dc8aa4164ac99b466f66bb9fb84befec097a.jpg)

## Installation

```bash
$ gem install bitbucket_pr
```

## Aliasing

This is optional you can always use `$ bitbucket_pr` as an executable,
but we'll be using `$ git pr` instead.

Create bash executable named `git-pr` with following snippet:

```bash
#!/bin/bash
bitbucket_pr "$@"
```

and add this to your path. On macOS you can place this in `~/bin`

## Usage

`source` `destination` and `title` are required options.

`username` `password` and `repository name` are also required, but can be saved for future.

#### Minimal setup 

```
$ git pr [source] [destination] -t[title] -a[username:password]`
```

example:
```
$ git pr middleware-patch master -rdachinat/rack_pg -adachinat:3Edm$51dd2 -t'Patching a middleware'
```

you can use `--title="Patching a middelware" --auth="username:password"` style if you want

#### Save credentials and repository name

##### Warning: this will create file containing your encrypted password. Use at your own risks! 

```
$ git pr configure -u[username] -p[password] -r[repository_name]
```

Repository name has to be in `username/repository` format

example: 

```
$ git pr configure -udachinat -p3Edm$51dd2 -rdachinat/rack_pg
```

Once you have credentials stored, you can skip `-r` and `-a` options

#### More options

* `-d` `--d` - Optional PR description
* `--reviewers` - Optional reviewer username array (i.e.: --reviewers="reviewer1, reviewer2") 
* `-c` `--close` - Optional close flag / close branch after PR is merged or not

#### Help

You can always use `git pr help` for further help 😄

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/dachinat/bitbucket_pr. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the BitbucketPr project’s codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/dachinat/bitbucket_pr/blob/master/CODE_OF_CONDUCT.md).
