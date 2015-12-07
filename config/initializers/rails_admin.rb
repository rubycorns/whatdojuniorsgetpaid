RailsAdmin.config do |config|
  config.actions do
    # root actions
    dashboard
    # only index collection action
    index
    # new, edit etc is NOT allowed
    export
    # member actions: only show
    show
  end
end
