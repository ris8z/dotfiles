local ls = require("luasnip")
local s = ls.snippet
local t = ls.text_node
local i = ls.insert_node

vim.keymap.set({ "i", "s" }, "<C-l>", function()
    if ls.expand_or_jumpable() then
        ls.expand_or_jump()
    end
end, { silent = true })

vim.keymap.set({ "i", "s" }, "<C-h>", function()
    if ls.jumpable(-1) then
        ls.jump(-1)
    end
end, { silent = true })

--:set filetype to get the first string
ls.add_snippets("lua", {
    s("hello", {
        t("print('hello "),
        i(1),
        t(" my "),
        i(2),
        t(" darling')"),
    }),
})

--to make more line snippet use fmt
local fmt = require("luasnip.extras.fmt").fmt
local extras = require("luasnip.extras")
local rep = extras.rep

ls.add_snippets("lua", {
    s("beg",fmt(
    [[
    \begin{{{}}} 
       {}
    \end{{{}}}
    ]], {
            i(1), i(0), rep(1)
    })),
})


--real snippet
ls.add_snippets("htmldjango", {
    s("bcss",fmt(
    [[
     <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet"
        integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous" />
    ]], {
    })),
})


ls.add_snippets("htmldjango", {
    s("bjs",fmt(
    [[
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"
        integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz"
        crossorigin="anonymous"></script>
    ]], {
    })),
})

ls.add_snippets("htmldjango", {
    s("bflashred",fmt(
    [[
    <div class="alert alert-danger alert-dismissible fade show" role="alert">
        {{message}}
        <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
    </div>
    ]], {
    })),
})

ls.add_snippets("htmldjango", {
    s("bflashgreen",fmt(
    [[
    <div class="alert alert-success alert-dismissible fade show" role="alert">
        {{message}}
        <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
    </div>
    ]], {
    })),
})

ls.add_snippets("htmldjango", {
    s("bform",fmt(
    [[
    <div class="container min-vh-100 d-flex justify-content-center align-items-center">
        <form>
            <div class="mb-3">
                <label for="exampleInputEmail1" class="form-label">Email address</label>
                <input type="email" class="form-control" id="exampleInputEmail1" aria-describedby="emailHelp" />
                <div id="emailHelp" class="form-text">
                    We'll never share your email with anyone else.
                </div>
            </div>
            <div class="mb-3">
                <label for="exampleInputPassword1" class="form-label">Password</label>
                <input type="password" class="form-control" id="exampleInputPassword1" />
            </div>
            <div class="mb-3 form-check">
                <input type="checkbox" class="form-check-input" id="exampleCheck1" />
                <label class="form-check-label" for="exampleCheck1">Check me out</label>
            </div>
            <button type="submit" class="btn btn-primary">Submit</button>
        </form>
    </div>
    ]], {
    })),
})

ls.add_snippets("htmldjango", {
    s("bnavbar",fmt(
    [[
    <!--set paddint-top: 56px for the body -->
    <nav class="navbar fixed-top navbar-expand-sm navbar-dark bg-dark">
        <div class="container">
            <a href="#" class="navbar-brand mb-0 h1">
                <img class="d-inline-block align-bottom"
                    src="https://getbootstrap.com/docs/4.0/assets/brand/bootstrap-solid.svg" width="30" height="30" />
            </a>
            <button type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav" class="navbar-toggler"
                aria-controls="navbarNav" aria-expanded="false" aria-label="Toggole navigation">
                <span class="navbar-toggler-icon"></span>
            </button>
            <div class="collapse navbar-collapse" id="navbarNav">
                <ul class="navbar-nav">
                    <li class="nav-item">
                        <a href="#" class="nav-link active"> Home </a>
                    </li>

                    <li class="nav-item dropdown">
                        <a href="#" class="nav-link dropdown-toggle" id="navbarDropdown" role="button"
                            data-bs-toggle="dropdown" aria-expanded="false">
                            Featurs
                        </a>
                        <ul class="dropdown-menu dropdown-menu-dark" aria-labelledby="navbarDropdown">
                            <li><a href="#" class="dropdown-item">Featurs1</a></li>
                            <li><a href="#" class="dropdown-item">Featurs2</a></li>
                            <li><a href="#" class="dropdown-item">Featurs2</a></li>
                        </ul>
                    </li>

                    <li class="nav-item">
                        <a href="#" class="nav-link"> About</a>
                    </li>
                </ul>
            </div>
        </div>
    </nav>
    ]], {
    })),
})





return {}
