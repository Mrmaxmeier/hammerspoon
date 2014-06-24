api.doc.textgrid.textgrids = {"api.textgrid.textgrids = {}", "All currently open textgrid windows; do not mutate this at all."}
api.textgrid.textgrids = {}
api.textgrid.textgrids.n = 0

api.doc.textgrid.open = {"api.textgrid.open() -> textgrid", "Opens a new textgrid window."}
function api.textgrid.open()
  local tg = api.textgrid._open()

  local id = api.textgrid.textgrids.n + 1
  tg.__id = id

  api.textgrid.textgrids[id] = tg
  api.textgrid.textgrids.n = id

  return tg
end

api.doc.textgrid.close = {"api.textgrid:close()", "Closes the given textgrid window."}
function api.textgrid:close()
  api.textgrid.textgrids[self.__id] = nil
  return self:_close()
end

api.doc.textgrid.livelong = {"api.textgrid:livelong()", "Prevents the textgrid from closing when your config is reloaded."}
function api.textgrid:livelong()
  api.textgrid.textgrids[self.__id] = nil
  self.__id = nil
end

function api.textgrid.closeall()
  for i, tg in pairs(api.textgrid.textgrids) do
    if i ~= "n" and tg ~= nil then
      api.textgrid.textgrids[i] = tg
      tg:close()
    end
  end
end
