<script>
	import Header from './Header.svelte';
	import '../app.css';
	import TitleBar from '$lib/components/TitleBar.svelte';
</script>

<div class="app">
	<TitleBar />
	<Header />
	<main>
		<slot />
	</main>
</div>

<style>
	main {
		flex: 1;
		display: flex;
		flex-direction: column;
		padding: 1rem;
		width: 100%;
		max-width: 64rem;
		margin: 0 auto;
		box-sizing: border-box;
	}
</style>
