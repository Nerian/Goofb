// Place your application-specific JavaScript functions and classes here
// This file is automatically included by javascript_include_tag :defaults


$(document).ready(function(){
	$("input[name='album']").change(function()
	{
	    if( $(this).is(':checked') )
	    {
	        $("input[type='checkbox']","ul").attr('checked',true);
	    } else
	    {                                           ,
	        $("input[type='checkbox']","ul").attr('checked',false);
	    }
	});

	$("input[type='checkbox']","ul").each(function()
	{
	    $(this).change(function()
	    {
	        if( ! $(this).is(':checked') )
	        {
	            $("input[name='album']").attr('checked',false);
	        }
	        if( $("input[type='checkbox']","ul").length == $("input[type='checkbox']:checked","ul").length )
	        {
	            $("input[name='album']").attr('checked',true);
	        }
	    });
	});          
});