{extends file="layout.tpl"}

{block name=title}{"problems"|_|ucfirst}{/block}

{block name=content}
  <h3>{"problems"|_}</h3>

  <ul>
    {foreach from=$problems item=p}
      <li><a href="{$wwwRoot}problem.php?id={$p->id}">{$p->name}</a></li>
    {/foreach}
  </ul>

  {if $canAdd}
    <a href="editProblem.php">{"add a problem"|_}</a>
  {/if}
{/block}
