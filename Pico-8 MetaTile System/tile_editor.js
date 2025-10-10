tileX = 0
tileY = 0
tileSetArr = []
selectedTile = 0
mapSelected = 0
mapArr = []
for (let i = 0; i < 32; i ++)
{
    mapArr.push([])
    for (let j = 0; j < 128; j ++)
    {
        mapArr[i].push(0)
    }
}
console.log(mapArr)
for (let i = 0; i < 32; i ++)
{
    tileSetArr.push([])
    for (let j = 0; j < 32; j++)
    {
        tileSetArr[i].push({sprite: 0,hFlip: false,vFlip: false})
    }
}
console.log(tileSetArr)
function create_tiles() {
    vert = document.getElementsByName("Vertical Flip")[0]
    vert.addEventListener('click',(e) => {
        update_tiles()
    })
    hor = document.getElementsByName("Horizontal Flip")[0]
    hor.addEventListener('click',(e) => {
        update_tiles()
    })

    buffcnv = document.createElement("canvas");
    buffcnv.height = 8
    buffcnv.width = 8
    buffcnv.hidden = true
    buffcnv.id = "buffer_canvas"
    cnv = document.createElement("canvas");
    cnv.height = 512
    cnv.width = 512
    cnv.style = "border:4px solid #000000"
    cnv.id = "tile_select"
    tileCnv = document.createElement("canvas")
    tileCnv.height = 512
    tileCnv.width = 512
    tileCnv.style = "border:4px solid #000000"
    tileCnv.id = "tile_place"

    selectCnv = document.createElement("canvas")
    selectCnv.height = 32
    selectCnv.width = 32
    selectCnv.style = "border:4px solid #000000"
    selectCnv.id = "selection"
    let title = document.getElementById('title')
    title.append(selectCnv)

    let tileH = document.getElementById("tile_holder")
    tileH.append(cnv)
    tileH.append(tileCnv)
    tileH.append(buffcnv)
    update_tiles()
    update_tile_canvas()
    cnv.addEventListener('mousemove',(e) => {
        update_tiles()
        let cnv = document.getElementById("tile_select")
        let ctx = cnv.getContext('2d')
        mouseVec2 = getMousePos(cnv,e)
        ctx.beginPath()
        ctx.strokeStyle = "blue"
        ctx.lineWidth = "3"
        ctx.rect(Math.floor(mouseVec2.x/32)*32,Math.floor(mouseVec2.y/32)*32,32,32)
        ctx.stroke()
    })

    tileCnv.addEventListener('mousemove',(e) => {
        update_tile_canvas()
        let cnv = document.getElementById("tile_place")
        let ctx = cnv.getContext('2d')
        mouseVec2 = getMousePos(cnv,e)
        ctx.beginPath()
        ctx.strokeStyle = "blue"
        ctx.lineWidth = "3"
        ctx.rect(Math.floor(mouseVec2.x/16)*16,Math.floor(mouseVec2.y/16)*16,16,16)
        ctx.stroke()
    })

    cnv.addEventListener('mousedown',(e) => {
        let cnv = document.getElementById("tile_select")
        let ctx = cnv.getContext('2d')
        mouseVec2 = getMousePos(cnv,e)
        tileX = Math.floor(mouseVec2.x/32)
        tileY = Math.floor(mouseVec2.y/32)
        s = tileX + tileY * 16
        if (selectedTile != s)
        {
            resetFlips()
        }
        selectedTile = s
        console.log(mouseVec2)
        update_tiles()
        update_map_editor()
    })

    tileCnv.addEventListener('mousedown',(e) => {
        let cnv = document.getElementById("tile_place")
        mouseVec2 = getMousePos(cnv,e)
        tileX = Math.floor(mouseVec2.x/16)
        tileY = Math.floor(mouseVec2.y/16)
        vert = document.getElementsByName("Vertical Flip")[0]
        hor = document.getElementsByName("Horizontal Flip")[0]
        tileSetArr[tileY][tileX].sprite = selectedTile
        tileSetArr[tileY][tileX].hFlip = (hor.checked)
        tileSetArr[tileY][tileX].vFlip = (vert.checked)

        update_tile_canvas()
        update_map_editor()
    })

    btn = document.getElementById("stringer")
    btn.addEventListener("click",(e) => {
        txt = document.getElementById("exporter")
        st = ""
        for (y=0;y<32;y++)
        {
            for (x=0;x<32;x++)
            {
                hex = tileSetArr[y][x].sprite.toString(16)
                if (hex.length == 1)
                {
                    hex = "0"+hex
                }
                hex += (tileSetArr[y][x].hFlip ? "1" : "0") + (tileSetArr[y][x].vFlip ? "1" : "0")
                st+=hex
            }
        }
        txt.value = st

        txt = document.getElementById("map_exporter")
        st = ""
        for (y=0;y<32;y++)
        {
            for (x=0;x<128;x++)
            {
                hex = mapArr[y][x].toString(16)
                if (hex.length == 1)
                {
                    hex = "0"+hex
                }
                st += hex
            }
            st += '\n'
        }
        txt.value = st
    })
    btn = document.getElementById("load_from_file")
    btn.addEventListener("click",(e) => {

        console.log(e)
        info_files = document.getElementById("info_file").files
        if (info_files.length <=0)
        {
            alert("please upload an accepted JSON file")
            return false
        }

        var fr = new FileReader();

        fr.onload = function(e) { 
            console.log(e);
              var result = JSON.parse(e.target.result)
                  console.log(result)
                  mapArr = result.map
                  tileSetArr = result.tile
                  update_map_editor()
                  update_tile_canvas()
                  update_tiles()
            }
        fr.readAsText(info_files.item(0))
        console.log()
    })
    btn = document.getElementById("save_data")
    btn.addEventListener("click",(e) => {
        st = JSON.stringify({map:mapArr,tile:tileSetArr})
        download(st,"map_file.txt","text/plain")
    })

}

function download(content, fileName, contentType) {
    var a = document.createElement("a");
    var file = new Blob([content], {type: contentType});
    a.href = URL.createObjectURL(file);
    a.download = fileName;
    a.click();
}

function create_map() {
    hold = document.getElementById("tile_select")

    cnv = document.createElement("canvas")
    cnv.width = 256
    cnv.height = 256
    cnv.id = "map_tiles"
    hold.append(cnv)

    hold = document.getElementById("mapper")

    
    cnv.addEventListener("mousemove",(e) => {
        update_tile_canvas()
        cnv = document.getElementById("map_tiles")
        mouseVec2 = getMousePos(cnv,e)
        ctx = cnv.getContext("2d")
        ctx.beginPath()
        ctx.strokeStyle = "blue"
        ctx.lineWidth = "2"
        ctx.rect(Math.floor(mouseVec2.x/16)*16,Math.floor(mouseVec2.y/16)*16,16,16)
        ctx.stroke()
    })
    cnv.addEventListener("mousedown",(e) => {
        cnv = document.getElementById("map_tiles")
        mouseVec2 = getMousePos(cnv,e)
        mapSelected = Math.floor(mouseVec2.x/16) + Math.floor(mouseVec2.y/16) * 16

        update_map_editor()
        update_tile_canvas()
    })


    cnv = document.createElement("canvas")
    cnv.width = 2048
    cnv.height = 512
    cnv.id = "map_big"
    hold.append(cnv)
    cnv.addEventListener("mousemove",(e) => {
        update_map_editor()
        cnv = document.getElementById("map_big")
        mouseVec2 = getMousePos(cnv,e)
        ctx = cnv.getContext("2d")
        ctx.beginPath()
        ctx.strokeStyle = "blue"
        ctx.lineWidth = "2"
        ctx.rect(Math.floor(mouseVec2.x/16)*16,Math.floor(mouseVec2.y/16)*16,16,16)
        ctx.stroke()
    })
    cnv.addEventListener("click",(e) => {
        cnv = document.getElementById("map_big")
        mouseVec2 = getMousePos(cnv,e)
        mx = Math.floor(mouseVec2.x/16)
        my = Math.floor(mouseVec2.y/16)
        mapArr[my][mx]= mapSelected
        update_map_editor()

    })

    cnv = document.createElement("canvas")
    cnv.width = 1024
    cnv.height = 256
    cnv.style = "padding: 2px; border:4px solid #ffc400"
    cnv.id = "map_small"
    hold = document.getElementById("tile_select")
    hold.append(cnv)


}
document.addEventListener('DOMContentLoaded', (e) => {
    setTimeout(() => {
        create_map()
        create_tiles()
        update_map_editor()
    },200);
})

function update_map_editor() {
    cnv = document.getElementById("map_big")
    cnv2 = document.getElementById("map_small")
    tilecnv = document.getElementById("map_tiles")
    maincnv = document.getElementById("tile_select")
    ctx = cnv.getContext('2d')
    ctx2 = cnv2.getContext('2d')
    for (x=0;x<128;x++)
    {
        for (y=0;y<32;y++)
        {
            let m = mapArr[y][x]
            let mx = (m%16) * 16
            let my = Math.floor(m/16) * 16
            ctx.drawImage(tilecnv,mx,my,16,16,x*16,y*16,16,16)
            ctx2.drawImage(maincnv,mx*2,my*2,32,32,x*8,y*8,8,8)
        }
    }
    for (x = 0; x < 16; x ++)
    {
        ctx.beginPath()
        ctx.strokeStyle = "white"
        ctx.lineWidth = 2
        ctx.moveTo(x*128,0)
        ctx.lineTo(x*128,512)
        ctx.stroke()
    }
    for (x = 0; x < 4; x ++)
    {
        ctx.beginPath()
        ctx.strokeStyle = "white"
        ctx.lineWidth = 2
        ctx.moveTo(0,x*128)
        ctx.lineTo(2048,x*128)
        ctx.stroke()
    }

}




function update_tile_canvas() {


    let cnv = document.getElementById("tile_place")
    let buffcnv = document.getElementById("buffer_canvas")
    let buffctx = bctx(buffcnv)
    let ctx = bctx(cnv)
    let img = document.getElementById("tiles")
    for (let y = 0; y < 32; y ++)
    {
        for (let x = 0; x < 32; x ++)
        {
            let sprite = tileSetArr[y][x].sprite
            sx = sprite%16
            sy = Math.floor(sprite/16)

            scaleX = 1
            scaleY = 1
            if (tileSetArr[y][x].hFlip)
            {
                scaleX = -1
            }
            if (tileSetArr[y][x].vFlip)
            {
                scaleY = -1
            }
            buffctx.setTransform(scaleX,0,0,scaleY,0,0)
            buffctx.drawImage(img,sx*8,sy*8,8,8,0 + (scaleX == -1 ? -8:0),0 + (scaleY == -1 ? -8:0),8,8)
            ctx.drawImage(buffcnv,x*16,y*16,16,16)
        }
    }
    mapC = document.getElementById("map_tiles")
    mCtx = mapC.getContext("2d")
    mCtx.drawImage(cnv,0,0,256,256)
    xx = mapSelected%16
    yy = Math.floor(mapSelected/16)
    mCtx.beginPath()
    mCtx.lineWidth = 2
    mCtx.strokeStyle = "red"
    mCtx.rect(xx*16,yy*16,16,16)
    mCtx.stroke()


    for (let x = 0; x < 17; x ++)
    {
        ctx.beginPath()
        ctx.strokeStyle = "red"
        ctx.moveTo(x*32,0)
        ctx.lineTo(x*32,512)
        ctx.stroke()
        ctx.beginPath()
        ctx.strokeStyle = "red"
        ctx.moveTo(0,x*32)
        ctx.lineTo(512,x*32)
        ctx.stroke()

    }
    //update_map_editor()
}



function update_tiles() {
    let img = document.getElementById("tiles")
    let selectCnv = document.getElementById("selection")
    let ctx = bctx(selectCnv)
    xx = selectedTile%16
    yy = Math.floor(selectedTile/16)
    vert = document.getElementsByName("Vertical Flip")[0]
    hor = document.getElementsByName("Horizontal Flip")[0]
    scaleX = 1
    scaleY = 1
    if (hor.checked)
    {
        scaleX = -1
    }
    if (vert.checked)
    {
        scaleY = -1
    }
    ctx.setTransform(scaleX,0,0,scaleY,0,0)
    ctx.drawImage(img,xx*8,yy*8,8,8,0 + (scaleX == -1 ? -32 : 0),0 + (scaleY == -1 ? -32 : 0),32,32)
    //update_map_editor()
    let cnv = document.getElementById("tile_select")
    ctx = bctx(cnv)
    ctx.drawImage(img,0,0,512,512)
    ctx.beginPath()
    ctx.strokeStyle = "red"
    ctx.lineWidth = "3"
    ctx.rect(tileX*32,tileY*32,32,32)
    ctx.stroke()
}

function getMousePos(canvas, evt) {
    var rect = canvas.getBoundingClientRect();
    return {
      x: evt.clientX - rect.left,
      y: evt.clientY - rect.top
    };
}


function resetFlips() {
    vert = document.getElementsByName("Vertical Flip")[0]
    vert.checked = false
    hor = document.getElementsByName("Horizontal Flip")[0]
    hor.checked = false
}

function bctx(can)
{
    ctx = can.getContext('2d')
    ctx.webkitImageSmoothingEnabled = false;
    ctx.mozImageSmoothingEnabled = false;
    ctx.imageSmoothingEnabled = false;
    return ctx
}