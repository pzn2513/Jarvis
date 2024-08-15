<script lang="ts">
	import { jsonModel } from "$lib/jsonModel";
	import {
		applyBold,
		applyItalic,
		applyUnderline,
		createLink,
	} from "$lib/editorCommands";

	let editorContent: string = "";

	function handleInput(event: Event) {
		const target = event.target as HTMLElement;
		editorContent = target.innerHTML;
		// 你可以在这里更新 JSON 数据模型并触发视图的重新渲染
	}

	function handleCreateLink() {
		const url = prompt("Enter the URL", "https://");
		if (url) {
			createLink(url);
		}
	}
</script>

<svelte:head>
	<title>Home</title>
	<meta name="description" content="Svelte demo app" />
</svelte:head>

<div class="toolbar">
	<button on:click={applyBold}>Bold</button>
	<button on:click={applyItalic}>Italic</button>
	<button on:click={applyUnderline}>Underline</button>
	<button on:click={handleCreateLink}>Link</button>
</div>

<div id="editor" contenteditable="true" on:input={handleInput} class="editor">
	{#each jsonModel.content as item (item.text)}
		{#if item.type === "paragraph"}
			<p>{item.text}</p>
		{/if}
		{#if item.type === "image"}
			<img src={item.src} alt={item.alt} />
		{/if}
	{/each}
</div>

<style>
	.toolbar {
		margin-bottom: 10px;
	}

	.toolbar button {
		margin-right: 5px;
		padding: 5px;
	}

	.editor {
		padding: 10px;
		border: 1px solid #ccc;
		min-height: 500px;
		background-color: #fff;
	}
</style>
