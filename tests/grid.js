
describe("CanvasGrid", function() {
    describe("coordinates", function(){
        it("chooses correct cell on mouseover", function(){
            var spec = {
                "xCount": 16,
                "yCount": 10,
                "xStridePx": 5, // size in pixels of per-cell x dimension
                "yStridePx": 7, // size in pixels of per-cell y dimension
            };
            var grid = new CanvasGrid(spec);

            // assume a clientRect object,
            // so that the test can be run browserless.
            //
            // see visual explanation at:
            // https://developer.mozilla.org/en-US/docs/Web/API/Element/getBoundingClientRect
            grid.clientRect = {
                "left": 17,
                "top": 30,
                "right": 97,   // left + (xCount * xStridePx)
                "bottom": 100, // top + (yCount * yStridePx)
                "x": 17,
                "y": 30,
                "width": 80,  // xCount * xStridePx
                "height": 70, // yCount * yStridePx
            };

            // mouse inside the cell at grid coords (7, 3)
            // ~~ ((left + (7 * xStridePx)), (top + (3 * yStridePx)))
            // == ((17 + (7 * 5)), (30 + (3 * 7)))
            // == (52, 51)
            //
            // so that within (52 - xStridePx, 51 - yStridePx) is a hit
            grid.mouseover(52 - 3, 51 - 4);

            assert.equal(grid.mouseX, 7);
            assert.equal(grid.mouseY, 3);
        });
    });
});
