-- nvim-treesitter's archived `master` branch registers query directives that
-- expect one node per capture. Neovim 0.12 passes a list of nodes, so markdown
-- code blocks (and html <script>/<style>) crash with
-- "attempt to call method 'range' (a nil value)". Re-register the three
-- directives so they accept either shape. Delete this file when moving to the
-- `main` branch of nvim-treesitter.
local query = vim.treesitter.query
local opts = { force = true }

local function first_node(match, id)
  local node = match[id]
  if type(node) == "table" then
    node = node[#node]
  end
  return node
end

local aliases = {
  ex = "elixir",
  pl = "perl",
  sh = "bash",
  uxn = "uxntal",
  ts = "typescript",
}

query.add_directive("set-lang-from-info-string!", function(match, _, bufnr, pred, metadata)
  local node = first_node(match, pred[2])
  if not node then
    return
  end
  local alias = vim.treesitter.get_node_text(node, bufnr):lower()
  local ft = vim.filetype.match({ filename = "a." .. alias })
  metadata["injection.language"] = aliases[alias] or ft or alias
end, opts)

query.add_directive("set-lang-from-mimetype!", function(match, _, bufnr, pred, metadata)
  local node = first_node(match, pred[2])
  if not node then
    return
  end
  local mimetypes = {
    importmap = "json",
    module = "javascript",
    ["application/ecmascript"] = "javascript",
    ["text/ecmascript"] = "javascript",
  }
  local value = vim.treesitter.get_node_text(node, bufnr)
  local parts = vim.split(value, "/", {})
  metadata["injection.language"] = mimetypes[value] or parts[#parts]
end, opts)

query.add_directive("downcase!", function(match, _, bufnr, pred, metadata)
  local id = pred[2]
  local node = first_node(match, id)
  if not node then
    return
  end
  local text = vim.treesitter.get_node_text(node, bufnr, { metadata = metadata[id] }) or ""
  if not metadata[id] then
    metadata[id] = {}
  end
  metadata[id].text = string.lower(text)
end, opts)
