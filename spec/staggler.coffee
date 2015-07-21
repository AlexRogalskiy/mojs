
Staggler = mojs.Staggler

describe 'Staggler ->', ->
  describe '_getOptionByMod method ->', ->
    it 'should get an option by modulo of i', ->
      options = bit: ['foo', 'bar', 'baz']
      s = new Staggler
      expect(s._getOptionByMod('bit', 0, options)).toBe 'foo'
      expect(s._getOptionByMod('bit', 1, options)).toBe 'bar'
      expect(s._getOptionByMod('bit', 2, options)).toBe 'baz'
      expect(s._getOptionByMod('bit', 3, options)).toBe 'foo'
      expect(s._getOptionByMod('bit', 7, options)).toBe 'bar'
    it 'should return option if it isnt defined by array', ->
      options = bit: 'foo'
      s = new Staggler
      expect(s._getOptionByMod('bit', 0, options)).toBe 'foo'
      expect(s._getOptionByMod('bit', 1, options)).toBe 'foo'
    it 'should get option if it is array like', ->
      div1 = document.createElement 'div'
      div2 = document.createElement 'div'
      divWrapper = document.createElement 'div'
      divWrapper.appendChild div1
      divWrapper.appendChild div2
      options = bit: divWrapper.childNodes
      s = new Staggler
      expect(s._getOptionByMod('bit', 0, options)).toBe div1
      expect(s._getOptionByMod('bit', 1, options)).toBe div2
  
  describe '_getOptionByIndex method ->', ->
    it 'should get option by modulo of index', ->
      options =
        bax:  ['foo', 'bar', 'baz']
        qux:  200
        norf: ['norf', 300]
      s = new Staggler
      option1 = s._getOptionByIndex 0, options
      expect(option1.bax) .toBe 'foo'
      expect(option1.qux) .toBe 200
      expect(option1.norf).toBe 'norf'

  describe '_getChildQuantity method', ->
    it 'should get quantity of child modules #array', ->
      options = el: ['el', 'b', 'c']
      s = new Staggler
      expect(s._getChildQuantity 'el', options).toBe 3
    it 'should get quantity of child modules #dom list', ->
      div1 = document.createElement 'div'
      div2 = document.createElement 'div'
      divWrapper = document.createElement 'div'
      divWrapper.appendChild div1
      divWrapper.appendChild div2
      options = el: divWrapper.childNodes
      s = new Staggler
      expect(s._getChildQuantity 'el', options).toBe 2
    it 'should get quantity of child modules #single value', ->
      options = el: document.createElement 'div'
      s = new Staggler
      expect(s._getChildQuantity 'el', options).toBe 1
    it 'should get quantity of child modules #string', ->
      options = el: '#selector'
      s = new Staggler
      expect(s._getChildQuantity 'el', options).toBe 1
  describe '_createTimeline method ->', ->
    it 'should create timeline', ->
      s = new Staggler
      s._createTimeline()
      expect(s.timeline instanceof mojs.Timeline).toBe true
  describe 'init ->', ->
    it 'should make stagger', ->
      div = document.createElement 'div'
      options = el: [div, div], path: 'M0,0 L100,100', delay: '200'
      s = new Staggler
      s.init options, mojs.MotionPath
      expect(s.timeline.timelines.length).toBe 2
    it 'should pass isRunLess = true', ->
      div = document.createElement 'div'
      options = el: [div, div], path: 'M0,0 L100,100', delay: '200'
      s = new Staggler
      s.init options, mojs.MotionPath
      expect(s.childModules[0].o.isRunLess).toBe true
    it 'should return self', ->
      div = document.createElement 'div'
      options = el: [div, div], path: 'M0,0 L100,100', delay: '200'
      s = new Staggler
      expect(s.init options, mojs.MotionPath).toBe s

  describe 'run method ->', ->
    it 'should run timeline', ->
      div = document.createElement 'div'
      options = el: [div, div], path: 'M0,0 L100,100', delay: '200'
      s = new Staggler
      s.init options, mojs.MotionPath
      spyOn s.timeline, 'start'
      s.run()
      expect(s.timeline.start).toHaveBeenCalled()

