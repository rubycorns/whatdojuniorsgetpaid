RailsAdmin.config do |config|
  config.actions do
    # no root actions
    # only index collection action
    index
    # new, edit etc is NOT allowed
    export
    # member actions: only show
    show
  end
end
