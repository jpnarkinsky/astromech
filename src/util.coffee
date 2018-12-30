Function::getter = (prop, get) ->
  Object.defineProperty @prototype, prop, { get, configurable: yes }

Function::setter = (prop, set) ->
  Object.defineProperty @prototype, prop, { set, configurable: yes }

