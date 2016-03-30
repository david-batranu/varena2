{extends file="layout.tpl"}

{block name=title}
  {($problem->name) ? {$problem->name} : "new problem"|_}
{/block}

{block name=content}
  <h3>
    {if $problem->id}
      {"edit problem"|_}
    {else}
      {"add a problem"|_}
    {/if}
  </h3>

  {if isset($previewed)}
    <div class="container">
      <div class="alert alert-warning col-md-6 col-md-offset-3 col-sm-8 col-sm-offset-2">
        {"This is only a preview. Don't forget to save your changes!"|_}
      </div>
    </div>

    <div class="panel panel-info">
      <div class="panel-heading">
        <div class="panel-title">{$problem->name}</div>
      </div>

      <div class="panel-body" id="statement">
        {$problem->getHtml()}
      </div>
    </div>
  {/if}

  <form method="post" role="form">
    <div>
      <!-- Nav tabs -->
      <ul class="nav nav-tabs" role="tablist">
        <li role="presentation" class="active">
          <a href="#statementTab" aria-controls="eval" role="tab" data-toggle="tab">
            {"statement"|_}
          </a>
        </li>
        <li role="presentation">
          <a href="#parametersTab" aria-controls="source" role="tab" data-toggle="tab">
            {"parameters"|_}
          </a>
        </li>
      </ul>

      <div class="voffset3"></div>

      <!-- Tab panes -->
      <div class="tab-content">
        <div role="tabpanel" class="tab-pane active" id="statementTab">

          {* Cannot reuse code here - label + input + button *}
          <label for="name">{"name"|_}</label>
          <div class="input-group {if isset($errors.name)}has-error{/if}">
            <input type="text"
                   class="form-control"
                   id="name"
                   name="name"
                   value="{$problem->name}"
                   placeholder="{"problem name"|_}">
            <span class="input-group-btn">
              <button type="submit"
                      class="btn btn-default"
                      name="generate"
                      title="{"generate a statement template based on the problem's name"|_}">
                <i class="glyphicon glyphicon-pencil"></i>
                {"generate template"|_}
              </button>
            </span>
          </div>
          {include "bits/fieldErrors.tpl" errors=$errors.name|default:null}

          <div class="form-group {if isset($errors.statement)}has-error{/if}">
            <label for="statement">{"statement"|_}</label>
            <textarea class="form-control"
                      rows="20"
                      id="statement"
                      name="statement"
                      placeholder="{"problem statement"|_}"
                      autofocus
                      >{$problem->statement}</textarea>
            {include "bits/fieldErrors.tpl" errors=$errors.statement|default:null}
          </div>
        </div>

        <div role="tabpanel" class="tab-pane" id="parametersTab">
          {include "bits/fgf.tpl" field="timeLimit" step="0.01" label={"time limit (seconds)"|_}}
          {include "bits/fgf.tpl" field="memoryLimit" label={"memory limit (kibibytes)"|_}}
          {include "bits/fgf.tpl" field="numTests" label={"number of tests"|_}}
          {include "bits/fgf.tpl" field="testGroups" type="text" label={"test grouping"|_} placeholder={"e.g. 1-5; 6; 7; 8-10"|_}}
          {include "bits/fgf.tpl" field="grader" type="text" label={"grader"|_} placeholder={"leave empty for diff evaluation"|_}}

          <div class="checkbox">
            <label for="hasWitness">
              <input type="checkbox"
                     id="hasWitness"
                     name="hasWitness"
                     value="1"
                     {if $problem->hasWitness}checked{/if}>
              {"uses .ok files"|_}
            </label>
          </div>

        </div>

      </div>
    </div>

    <button type="submit" class="btn btn-default" name="preview">
      <i class="glyphicon glyphicon-refresh"></i>
      {"preview"|_}
    </button>
    <button type="submit" class="btn btn-default" name="save">
      <i class="glyphicon glyphicon-floppy-disk"></i>
      {"save"|_}
    </button>

    {if $problem->id}
      <a href="problem.php?id={$problem->id}">{"cancel"|_}</a>
    {else}
      <a href="problems.php">{"cancel"|_}</a>
    {/if}
  </form>
{/block}
