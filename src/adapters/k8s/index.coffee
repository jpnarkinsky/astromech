Adapter = require('../adapter')
Client = require('kubernetes-client').Client
K8sConfig = require('kubernetes-client').config

class K8sAdapter extends Adapter
  ## class methods
  constructor: (conn = {}) ->
     super(conn)
     this._config = K8sConfig.fromKubeconfig(conn.config, conn.context)
     this._client = new Client { config: this._config }
     this._client.loadSpec()

  ## Instance properties
  @getter 'client', -> this._client
  @getter 'config', -> this._config
  @getter 'currentContext', -> this._config.context

  

module.exports = KubernetesAdapter
