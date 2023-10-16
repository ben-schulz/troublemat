class CanvasGrid {

    _dispatch(eventType, clientX, clientY){
        var detail = {"detail": {"clientX": clientX, "clientY": clientY}};
        var event = new CustomEvent(eventType, detail);
        this.canvasEl.dispatchEvent(event);
    }

    constructor(spec){

        this.xCount = spec.xCount;
        this.yCount = spec.yCount;
        this.xStridePx = spec.xStridePx;
        this.yStridePx = spec.yStridePx;

        this.mouseX = null;
        this.mouseY = null;

        this.canvasEl = document.createElement("canvas");

    }

    mouseover(clientX, clientY){
        this._dispatch("mouseover", clientX, clientY);

        this.mouseX = clientX;
        this.mouseY = clientY;
    }
}
