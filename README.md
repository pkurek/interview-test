# Setup

```
bundle || rake db:setup
```

# Testing

```
rspec spec
```

# Dependencies

Right now it's only postgres but feel free to change the adapter to anything you want.
DB config is stored in `db/config.yml` and the adapter gem is installed through Gemfile.
