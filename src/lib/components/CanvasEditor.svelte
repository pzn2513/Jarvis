<script lang="ts">
    import { onMount } from 'svelte';
    let canvas: HTMLCanvasElement;
    let ctx: CanvasRenderingContext2D;
    let text = '';
    let fontSize = 16;
    let fontFamily = 'Arial';
    let color = '#000';
  
    onMount(() => {
      ctx = canvas.getContext('2d');
      ctx.font = `${fontSize}px ${fontFamily}`;
      ctx.fillStyle = color;
      redraw();
    });
  
    function handleInput(event: KeyboardEvent) {
      if (event.key === 'Backspace') {
        text = text.slice(0, -1);
      } else if (event.key.length === 1) {
        text += event.key;
      }
      redraw();
    }
  
    function redraw() {
      ctx.clearRect(0, 0, canvas.width, canvas.height);
      ctx.fillText(text, 10, fontSize);
    }
  
    function setFontSize(size: number) {
      fontSize = size;
      ctx.font = `${fontSize}px ${fontFamily}`;
      redraw();
    }
  
    function setFontFamily(family: string) {
      fontFamily = family;
      ctx.font = `${fontSize}px ${fontFamily}`;
      redraw();
    }
  
    function setColor(newColor: string) {
      color = newColor;
      ctx.fillStyle = color;
      redraw();
    }
  </script>
  
  <div on:keydown={handleInput} tabindex="0" style="outline: none;">
    <canvas bind:this={canvas} width="800" height="400" style="border: 1px solid #000;"></canvas>
  </div>
  
  <div>
    <label>
      Font Size:
      <input type="number" value={fontSize} on:input={(e) => setFontSize(e.target.value)} />
    </label>
    <label>
      Font Family:
      <input type="text" value={fontFamily} on:input={(e) => setFontFamily(e.target.value)} />
    </label>
    <label>
      Color:
      <input type="color" value={color} on:input={(e) => setColor(e.target.value)} />
    </label>
  </div>
  