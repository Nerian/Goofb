$("input[name='album']").change(function()
{
	if( $(this).is(':checked') )
	{
		$("input[type='checkbox']","ul").attr('checked',true);
	} 
	else
	{
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
	});
});