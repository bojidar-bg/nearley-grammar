NearleyGrammarView = require './nearley-grammar-view'
{CompositeDisposable} = require 'atom'

module.exports = NearleyGrammar =
  nearleyGrammarView: null
  modalPanel: null
  subscriptions: null

  activate: (state) ->
    @nearleyGrammarView = new NearleyGrammarView(state.nearleyGrammarViewState)
    @modalPanel = atom.workspace.addModalPanel(item: @nearleyGrammarView.getElement(), visible: false)

    # Events subscribed to in atom's system can be easily cleaned up with a CompositeDisposable
    @subscriptions = new CompositeDisposable

    # Register command that toggles this view
    @subscriptions.add atom.commands.add 'atom-workspace', 'nearley-grammar:toggle': => @toggle()

  deactivate: ->
    @modalPanel.destroy()
    @subscriptions.dispose()
    @nearleyGrammarView.destroy()

  serialize: ->
    nearleyGrammarViewState: @nearleyGrammarView.serialize()

  toggle: ->
    console.log 'NearleyGrammar was toggled!'

    if @modalPanel.isVisible()
      @modalPanel.hide()
    else
      @modalPanel.show()
