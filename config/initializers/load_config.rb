APP_CONFIG = YAML.load(ERB.new(File.open(Rails.root.join 'config', 'config.yml').read).result)
