(function _FileTransformers_s_() {

'use strict';

/**
  @module Tools/mid/files/FilesTransformers - Collection of files transformers for Files module. Use it to read configs in different formats.
*/

/**
 * @file files/FilesTransformers.s.
 */

if( typeof module === 'undefined' )
return;

if( typeof module !== 'undefined' )
{
  if( typeof _global_ === 'undefined' || !_global_.wBase )
  {
    let toolsPath = '../../../dwtools/Base.s';
    let toolsExternal = 0;
    try
    {
      toolsPath = require.resolve( toolsPath );
    }
    catch( err )
    {
      toolsExternal = 1;
      require( 'wTools' );
    }
    if( !toolsExternal )
    require( toolsPath );
  }

  let _ = _global_.wTools;

  _.include( 'wFiles' );

}

let _global = _global_;
let _ = _global_.wTools;
let ReadEncoders = _.FileProvider.Partial.prototype.fileRead.encoders;
let WriteEncoders = _.FileProvider.Partial.prototype.fileWrite.encoders;

// --
//
// --

let Coffee;
try
{
  Coffee = require( 'coffee-script' );
}
catch( err )
{
}

if( Coffee )
ReadEncoders[ 'coffee' ] =
{

  exts : [ 'coffee' ],
  forInterpreter : 1,

  onBegin : function( e )
  {
    _.assert( e.operation.encoding === 'coffee' );
    e.operation.encoding = 'utf8';
  },

  onEnd : function( e )
  {
    _.assert( _.strIs( e.data ), '( fileRead.ReadEncoders.coffee.onEnd ) expects string' );
    e.data = Coffee.eval( e.data, { filename : e.operation.filePath } );
  },

}

let Js2coffee;
try
{
  Js2coffee = require( 'js2coffee' );
}
catch( err )
{
}

/* qqq : does not work, find solution */

if( Js2coffee )
WriteEncoders[ 'coffee' ] =
{

  exts : [ 'coffee' ],

  onBegin : function( e )
  {
    debugger;
    _.assert( e.operation.encoding === 'coffee' );
    try
    {
      e.operation.data = Js2coffee( JSON.stringify( e.operation.data ) );
    }
    catch( err )
    {
      debugger;
      throw _.err( err );
    }
    e.operation.encoding = 'utf8';
    debugger;
  },

}

//

let Yaml;
try
{
  Yaml = require( 'js-yaml' );
}
catch( err )
{
}

if( Yaml )
ReadEncoders[ 'yaml' ] =
{

  exts : [ 'yaml','yml' ],
  forInterpreter : 1,

  onBegin : function( e )
  {
    _.assert( e.operation.encoding === 'yaml' );
    e.operation.encoding = 'utf8';
  },

  onEnd : function( e )
  {
    _.assert( _.strIs( e.data ), '( fileRead.ReadEncoders.coffee.onEnd ) expects string' );
    try
    {
      e.data = Yaml.load( e.data,{ filename : e.operation.filePath } );
    }
    catch( err )
    {
      debugger;
      throw _.err( err );
    }
  },

}

if( Yaml )
WriteEncoders[ 'yaml' ] =
{

  exts : [ 'yaml','yml' ],

  onBegin : function( e )
  {
    _.assert( e.operation.encoding === 'yaml' );
    try
    {
      e.operation.data = Yaml.dump( e.operation.data );
    }
    catch( err )
    {
      debugger;
      throw _.err( err );
    }
    e.operation.encoding = 'utf8';
  },

}

// --
// export
// --

let Self = wTools.FileTransformers = ReadEncoders;

if( typeof module !== 'undefined' )
if( _global_.WTOOLS_PRIVATE )
{ /* delete require.cache[ module.id ]; */ }

if( typeof module !== 'undefined' && module !== null )
module[ 'exports' ] = Self;

})();
