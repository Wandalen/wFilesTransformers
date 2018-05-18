(function _FileTransformers_s_() {

'use strict';

if( typeof module === 'undefined' )
return;

var _ = _global_.wTools;
var encoders = _.FileProvider.Partial.prototype.fileRead.encoders;

// --
//
// --

try
{
  var Coffee = require( 'coffee-script' );
}
catch( err )
{
}

if( Coffee )
encoders[ 'coffee' ] =
{

  exts : [ 'coffee' ],
  forInterpreter : 1,

  onBegin : function( e )
  {
    _.assert( e.transaction.encoding === 'coffee' );
    e.transaction.encoding = 'utf8';
  },

  onEnd : function( e )
  {
    if( !_.strIs( e.data ) )
    throw _.err( '( fileRead.encoders.coffee.onEnd ) expects string' );
    var result = Coffee.eval( e.data,{ filename : e.transaction.filePath } );
    return result;
  },

}


//

try
{
  var Yaml = require( 'js-yaml' );
}
catch( err )
{
}

if( Yaml )
encoders[ 'yaml' ] =
{

  exts : [ 'yaml','yml' ],
  forInterpreter : 1,

  onBegin : function( e )
  {
    _.assert( e.transaction.encoding === 'yaml' );
    debugger;
    e.transaction.encoding = 'utf8';
  },

  onEnd : function( e )
  {
    if( !_.strIs( e.data ) )
    throw _.err( '( fileRead.encoders.coffee.onEnd ) expects string' );
    debugger;
    var result = Yaml.load( e.data,{ filename : e.transaction.filePath } );
    return result;
  },

}

// --
// export
// --

var Self = wTools.FileTransformers = encoders;

if( typeof module !== 'undefined' )
if( _global_._UsingWtoolsPrivately_ )
delete require.cache[ module.id ];

if( typeof module !== 'undefined' && module !== null )
module[ 'exports' ] = Self;

})();
