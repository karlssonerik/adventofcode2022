defmodule Day7 do
  def run do
    part1(input, "/", %{}, %{})
  end

  def part1(inputList, cPath, dirSizes, dirTree) do
    if length(inputList) != 0 do
      cLine = hd(inputList)
      cond do
        Regex.match?( ~r/^\$ cd/ , cLine) -> tl(inputList) |> part1(newPath(cLine, cPath), dirSizes, dirTree)
        Regex.match?( ~r/^\$ ls/ , cLine) ->listDir(inputList, cPath, dirSizes, dirTree)
        true -> tl(inputList) |> part1(cPath, dirSizes, dirTree)
      end
    else
      getDirSizes(Map.keys(dirTree), dirSizes, dirTree, 0, %{})
    end
  end

  def part2(totDirSizes) do
    diskSize = 70000000
    neededSize = 30000000
    currentSize = Map.get(totDirSizes, "/")
    toFree = neededSize -  (diskSize - currentSize)
    IO.puts(getMinFreeableDir(Map.keys(totDirSizes), totDirSizes, toFree, diskSize))
  end

  def getMinFreeableDir(dirs, totDirSizes,toFree, minSize) do
    if length(dirs) == 0 do
      minSize
    else
      dirSize = Map.get(totDirSizes,hd(dirs))
      if dirSize >= toFree && dirSize < minSize do
        getMinFreeableDir(tl(dirs), totDirSizes,toFree, dirSize)
      else
        getMinFreeableDir(tl(dirs), totDirSizes,toFree, minSize)
      end

    end
  end

  def listDir(inputList, cPath, dirSizes, dirTree) do
    dir = cPath
    subDirs = getSubDirs(tl(inputList), [], cPath)
    size = getSize(tl(inputList), 0)
    part1(tl(inputList), cPath,  Map.put(dirSizes, dir, size), Map.put(dirTree, dir, subDirs))
  end

  def getSubDirs(inputList, subDirs, cPath) do
    cond do
      length(inputList) == 0 -> subDirs
      Regex.match?( ~r/^\$/ , hd(inputList)) -> subDirs
      Regex.match?( ~r/^dir/ , hd(inputList)) ->
        subDir = String.split(hd(inputList), " ") |> Enum.at(1)
        subDirFull = Regex.replace(~r/\/\//,cPath<>"/"<>subDir, "/")
        getSubDirs(tl(inputList), subDirs ++ [subDirFull], cPath)
      true -> getSubDirs(tl(inputList), subDirs, cPath)
    end
  end

  def getDirSizes(dirs, dirSizes, dirTree, totSize, totDirSizes) do
    if length(dirs) != 0 do
      size = getDirSize(hd(dirs), Map.get(dirTree, hd(dirs)), dirSizes, dirTree)
      newTotDirSizes = Map.put(totDirSizes,hd(dirs), size)
      if size<= 100000 do
        getDirSizes(tl(dirs), dirSizes, dirTree, totSize + size, newTotDirSizes)
      else
        getDirSizes(tl(dirs), dirSizes, dirTree, totSize, newTotDirSizes)
      end
    else
      IO.puts(totSize)
      part2(totDirSizes)
    end
  end

  def getDirSize(dir, subDirs, dirSizes, dirTree) do
    if length(subDirs) != 0 do
      Map.get(dirSizes, dir) + getSubDirSize(subDirs, dirSizes, dirTree, 0)
    else
      Map.get(dirSizes, dir)
    end
  end

  def getSubDirSize(subDirs, dirSizes, dirTree, size) do
    if length(subDirs) != 0 do
      subDir =  hd(subDirs)
      newSize = getDirSize(subDir, Map.get(dirTree, subDir), dirSizes, dirTree)
      getSubDirSize(tl(subDirs), dirSizes, dirTree, newSize+size)
    else
      size
    end
  end

  def getSize(inputList, size) do
    cond do
      length(inputList) == 0 -> size
      Regex.match?( ~r/^\$/ , hd(inputList)) -> size
      Regex.match?( ~r/^dir/ , hd(inputList)) -> getSize(tl(inputList),size)
      true ->
        newSize = String.split(hd(inputList), " ") |> Enum.at(0) |> Integer.parse() |> elem(0)
        getSize(tl(inputList), size + newSize)
    end
  end

  def getDir(cPath) do
    dirs = String.split(cPath, "/") |> Enum.filter(fn x -> x != "" end)
    if length(dirs)== 0 do
      "/"
    else
      Enum.at(dirs, length(dirs)-1)
    end
  end

  def newPath(command, cPath) do
    cmdParts = String.split(command, " ")
    cond do
      Regex.match?( ~r/\.\./ , command) ->
        nPath = Regex.replace(~r/\/[a-z]+$/,cPath, "")
        if nPath == "" do
          "/"
        else
          nPath
        end
      Enum.at(cmdParts, 2) == "/" ->
        "/"
      true ->
        newPath1 = cPath <> "/" <> Enum.at(cmdParts, 2)
        Regex.replace(~r/\/\//, newPath1, "/")
    end
  end

  def inputEX do
      [
        "$ cd /",
        "$ ls",
        "dir a",
        "14848514 b.txt",
        "8504156 c.dat",
        "dir d",
        "$ cd a",
        "$ ls",
        "dir e",
        "29116 f",
        "2557 g",
        "62596 h.lst",
        "$ cd e",
        "$ ls",
        "584 i",
        "$ cd ..",
        "$ cd ..",
        "$ cd d",
        "$ ls",
        "4060174 j",
        "8033020 d.log",
        "5626152 d.ext",
        "7214296 k",
      ]
  end

  def input do
    [
      "$ cd /","$ ls","246027 gldg.jrd","dir qffvbf","dir qjjgh","dir vpjqpqfm","$ cd qffvbf","$ ls","dir dcqf","dir grcj","dir hwllqcd","76103 jrhp.hgg","253696 nscv.wvb","dir stnrzs","dir vzgpfd","$ cd dcqf","$ ls","dir gcjmpnsl","$ cd gcjmpnsl","$ ls","198360 gldg.jrd","$ cd ..","$ cd ..","$ cd grcj","$ ls","56512 grgtnhn.zdn","$ cd ..","$ cd hwllqcd","$ ls","100505 frzf.mzc","209030 gldg.jrd","9330 jjtjjlsr.dnl","191034 mfmps.vjt","82405 nscv.wvb","$ cd ..","$ cd stnrzs","$ ls","dir gmtmfpmb","dir jrhp","dir rhf","dir wzjtd","$ cd gmtmfpmb","$ ls","279472 hswhjhmj","81339 rsgsrn","$ cd ..","$ cd jrhp","$ ls","dir fpmnp","99771 grcj.scb","dir hjglg","dir hwvzv","$ cd fpmnp","$ ls","33215 grcj.tcj","$ cd ..","$ cd hjglg","$ ls","206893 tctfwpf.jhv","$ cd ..","$ cd hwvzv","$ ls","dir mfmps","$ cd mfmps","$ ls","46252 rjrmbqwr.wbj","$ cd ..","$ cd ..","$ cd ..","$ cd rhf","$ ls","222859 dcgvw","41140 grcj.qzh","dir zcjh","217515 zgqjbf","$ cd zcjh","$ ls","92243 prqhbzl.hls","$ cd ..","$ cd ..","$ cd wzjtd","$ ls","dir bnjj","dir dhhpf","dir grcj","dir jqmnp","16602 mfmps.dht","dir mrgh","112236 rsgsrn","dir wqwwwfd","243851 zgqjbf.bjh","$ cd bnjj","$ ls","158778 zjdvggcz.fhr","$ cd ..","$ cd dhhpf","$ ls","228680 gldg.jrd","18523 wcfpqqp.tcf","$ cd ..","$ cd grcj","$ ls","dir bcbspw","dir mpq","dir pjzw","$ cd bcbspw","$ ls","5449 rsgsrn","$ cd ..","$ cd mpq","$ ls","135338 mfmps","$ cd ..","$ cd pjzw","$ ls","dir cpffwn","$ cd cpffwn","$ ls","131835 rnwqngz","$ cd ..","$ cd ..","$ cd ..","$ cd jqmnp","$ ls","281939 nscv.wvb","103834 rsgsrn","34528 wcfpqqp.tcf","$ cd ..","$ cd mrgh","$ ls","dir grcj","$ cd grcj","$ ls","211470 bbzm.sbq","$ cd ..","$ cd ..","$ cd wqwwwfd","$ ls","59532 blfr.lqh","$ cd ..","$ cd ..","$ cd ..","$ cd vzgpfd","$ ls","dir grcj","dir lvhfqr","dir zgvjpnf","$ cd grcj","$ ls","160936 jbfsbsnn.sgj","dir mfmps","dir mfqjssr","dir vzgpfd","dir zgqjbf","$ cd mfmps","$ ls","176441 dcgvw","9961 grcj.sdl","dir mfmps","181303 nscv.wvb","273550 zfjhqtp","$ cd mfmps","$ ls","dir ndqjhlhp","$ cd ndqjhlhp","$ ls","43593 wcfpqqp.tcf","$ cd ..","$ cd ..","$ cd ..","$ cd mfqjssr","$ ls","137211 gldg.jrd","254301 grcj.rgv","$ cd ..","$ cd vzgpfd","$ ls","dir hqnfwtj","dir mtqzh","215717 thd.cgt","dir vgtvctd","dir vzgpfd","64282 zgqjbf","$ cd hqnfwtj","$ ls","155738 cjpqzq","128579 cnsm.mdt","150972 fpmjd","54851 rsgsrn","$ cd ..","$ cd mtqzh","$ ls","288824 bjnhtwg","209838 gldg.jrd","87464 jgdhm.wrb","dir nbnzfc","$ cd nbnzfc","$ ls","dir rtrbhtb","267378 wcfpqqp.tcf","152165 wsww.gdd","$ cd rtrbhtb","$ ls","264454 dcgvw","221078 jrhp.fsj","dir sgm","$ cd sgm","$ ls","dir tzzfc","$ cd tzzfc","$ ls","207888 cdmht.jjn","$ cd ..","$ cd ..","$ cd ..","$ cd ..","$ cd ..","$ cd vgtvctd","$ ls","dir dtm","dir gghjmgqs","dir grcj","dir lcpmlcpn","57113 njpnzq.phl","279566 rsgsrn","59404 tzl","221164 vcpzw.qsh","$ cd dtm","$ ls","dir pmsvz","dir zdzv","$ cd pmsvz","$ ls","dir qctt","$ cd qctt","$ ls","285640 wzh.hwv","$ cd ..","$ cd ..","$ cd zdzv","$ ls","178732 fdvth.rvs","dir jjslblcb","dir tvq","dir zgqjbf","$ cd jjslblcb","$ ls","dir grcj","$ cd grcj","$ ls","186485 wcfpqqp.tcf","$ cd ..","$ cd ..","$ cd tvq","$ ls","48035 jrhp.qnf","$ cd ..","$ cd zgqjbf","$ ls","276537 gldg.jrd","$ cd ..","$ cd ..","$ cd ..","$ cd gghjmgqs","$ ls","238068 qqczbf","$ cd ..","$ cd grcj","$ ls","dir qnn","$ cd qnn","$ ls","117284 jmst.mld","$ cd ..","$ cd ..","$ cd lcpmlcpn","$ ls","dir cbzpzsj","53036 frzslwl.qgd","82430 grcj","273768 pvzslpsn.ztw","67092 rsgsrn","$ cd cbzpzsj","$ ls","36456 gldg.jrd","95656 mfmps.cfl","2578 qpl.jhn","225756 sqt.njp","$ cd ..","$ cd ..","$ cd ..","$ cd vzgpfd","$ ls","266582 cgvcwrfn.jjq","230770 dcgvw","266361 gqqcqtp.hvq","dir lnn","86659 pzft.smj","180519 qfszrvm.gnq","dir rwrt","dir thrthq","dir zgqjbf","$ cd lnn","$ ls","13294 dqqvbcf","268614 mczrlg.vmz","dir wqccmlvq","dir zgqjbf","$ cd wqccmlvq","$ ls","dir grcj","$ cd grcj","$ ls","55504 gldg.jrd","6925 jbqzth.rcj","168475 jqzmc.sfm","$ cd ..","$ cd ..","$ cd zgqjbf","$ ls","172255 nptpqjd.hzz","$ cd ..","$ cd ..","$ cd rwrt","$ ls","78039 jrhp.cmf","237632 mfmps","$ cd ..","$ cd thrthq","$ ls","122514 jrhp.fcj","$ cd ..","$ cd zgqjbf","$ ls","dir dpbnq","dir mfmps","dir rbnzhhn","$ cd dpbnq","$ ls","dir vzgpfd","$ cd vzgpfd","$ ls","278947 bhdtwf","$ cd ..","$ cd ..","$ cd mfmps","$ ls","118315 mfmps.lbq","$ cd ..","$ cd rbnzhhn","$ ls","96386 svwv.ldj","$ cd ..","$ cd ..","$ cd ..","$ cd ..","$ cd zgqjbf","$ ls","196735 cmrdgjl.hbd","$ cd ..","$ cd ..","$ cd lvhfqr","$ ls","dir njzv","dir sgwzscp","dir zgqjbf","$ cd njzv","$ ls","60680 bmqh.snz","129703 wcfpqqp.tcf","$ cd ..","$ cd sgwzscp","$ ls","dir rnjrj","1799 vzgpfd","37203 zgqjbf.jwf","25768 zjh","$ cd rnjrj","$ ls","242223 blrzc","63563 plb.dlq","$ cd ..","$ cd ..","$ cd zgqjbf","$ ls","91151 cmn.gcw","235818 llsnw.phb","$ cd ..","$ cd ..","$ cd zgvjpnf","$ ls","158932 nscv.wvb","110912 wzm","$ cd ..","$ cd ..","$ cd ..","$ cd qjjgh","$ ls","dir cwslqsb","34405 dcgvw","dir fvmmd","dir jrhp","dir vflhljrl","239915 vzgpfd","$ cd cwslqsb","$ ls","49934 mqzfncgb.jbf","$ cd ..","$ cd fvmmd","$ ls","dir grcj","dir jrhp","dir sqmbncp","dir vzgpfd","$ cd grcj","$ ls","32276 bjgc","211068 mfmps","$ cd ..","$ cd jrhp","$ ls","218633 wpqh.jfl","$ cd ..","$ cd sqmbncp","$ ls","137187 tzqqm.jqr","$ cd ..","$ cd vzgpfd","$ ls","258286 hqg.qzn","dir mvqgb","236455 vqdtns","255724 wrnhw.mzf","192529 zgqjbf.zzb","$ cd mvqgb","$ ls","dir vzgpfd","$ cd vzgpfd","$ ls","200955 grcj.wwl","$ cd ..","$ cd ..","$ cd ..","$ cd ..","$ cd jrhp","$ ls","86368 dcgvw","16512 vzgpfd","245341 wcfpqqp.tcf","$ cd ..","$ cd vflhljrl","$ ls","82670 gldg.jrd","228251 nscv.wvb","$ cd ..","$ cd ..","$ cd vpjqpqfm","$ ls","246705 gfff","dir grcj","dir hjdwrt","dir mfmps","dir plrrsmph","dir rgqtzc","175555 rsgsrn","142983 wjpbr.hdr","dir zlv","$ cd grcj","$ ls","dir grcj","dir mdvcmm","285341 mfmps","89089 nscv.wvb","$ cd grcj","$ ls","dir fcdz","dir fswpmd","dir gvjjjp","dir jrhp","$ cd fcdz","$ ls","dir dpwvm","dir rmmw","$ cd dpwvm","$ ls","dir chjbpb","118852 dcgvw","dir dsc","7271 fclhnmz.cbp","$ cd chjbpb","$ ls","41211 pzr","$ cd ..","$ cd dsc","$ ls","217960 nscv.wvb","$ cd ..","$ cd ..","$ cd rmmw","$ ls","dir cqzvcv","dir hld","99687 jrhp.nnb","dir pfvthfw","97451 qjmfdjwz.phc","$ cd cqzvcv","$ ls","dir zgqjbf","$ cd zgqjbf","$ ls","204153 nscv.wvb","$ cd ..","$ cd ..","$ cd hld","$ ls","113905 pwqs","244609 wfsgg.jgp","$ cd ..","$ cd pfvthfw","$ ls","dir grcj","$ cd grcj","$ ls","207441 jrhp","$ cd ..","$ cd ..","$ cd ..","$ cd ..","$ cd fswpmd","$ ls","99446 gldg.jrd","$ cd ..","$ cd gvjjjp","$ ls","dir pvzz","279071 wdmm.vjv","$ cd pvzz","$ ls","196937 nqfzj","273491 nscv.wvb","dir qthbl","$ cd qthbl","$ ls","204553 dcgvw","$ cd ..","$ cd ..","$ cd ..","$ cd jrhp","$ ls","175979 fct.dcg","$ cd ..","$ cd ..","$ cd mdvcmm","$ ls","dir crscnnh","109461 dcdtm.tvp","279544 ftzvrpcw.pff","124059 nnc","274104 nscv.wvb","dir ssvd","dir zvvhlw","$ cd crscnnh","$ ls","dir tzbjl","$ cd tzbjl","$ ls","112219 wcfpqqp.tcf","$ cd ..","$ cd ..","$ cd ssvd","$ ls","227906 bsqhzw","$ cd ..","$ cd zvvhlw","$ ls","166628 gldg.jrd","$ cd ..","$ cd ..","$ cd ..","$ cd hjdwrt","$ ls","59644 jrhp.fjj","dir rpsrm","221706 rsgsrn","dir rzn","14344 tvlmvr.flr","dir vlbrnq","dir vrcns","39113 wcfpqqp.tcf","dir zhwm","$ cd rpsrm","$ ls","282957 wmpnpjzd","$ cd ..","$ cd rzn","$ ls","142973 wcfpqqp.tcf","$ cd ..","$ cd vlbrnq","$ ls","79661 ccznjt.fqr","$ cd ..","$ cd vrcns","$ ls","262645 dcnnnhn.vhg","$ cd ..","$ cd zhwm","$ ls","dir glgs","dir grcj","dir jrhp","$ cd glgs","$ ls","282326 tcw.qnb","$ cd ..","$ cd grcj","$ ls","43293 qnqb.jqg","$ cd ..","$ cd jrhp","$ ls","197274 pgf.ltc","$ cd ..","$ cd ..","$ cd ..","$ cd mfmps","$ ls","dir dcm","47902 mrcn.wtb","8444 mzdgdh.ctn","$ cd dcm","$ ls","72397 mnrvqg.vmm","$ cd ..","$ cd ..","$ cd plrrsmph","$ ls","216816 gldg.jrd","148190 jzbswh","120319 wcfpqqp.tcf","dir zgqjbf","$ cd zgqjbf","$ ls","dir cfdr","dir hdsnc","$ cd cfdr","$ ls","34272 bzctmbvt.qzr","$ cd ..","$ cd hdsnc","$ ls","43772 ccds.vlz","$ cd ..","$ cd ..","$ cd ..","$ cd rgqtzc","$ ls","dir dblznh","dir lfpdqm","dir lmnmthm","dir mfmps","dir pcplzs","dir pvfbjm","dir rnl","dir wqgp","dir zgqjbf","$ cd dblznh","$ ls","65168 tdv.mwq","$ cd ..","$ cd lfpdqm","$ ls","dir cgvnspv","dir dthhvrln","dir jrhp","dir vzgpfd","$ cd cgvnspv","$ ls","dir qnmg","$ cd qnmg","$ ls","dir grcj","70937 jbvrp.psn","207093 vfgds.tjv","282330 vtlzgq.dfd","251235 zbvgc.whr","$ cd grcj","$ ls","dir pbn","$ cd pbn","$ ls","22094 dqt.dtv","$ cd ..","$ cd ..","$ cd ..","$ cd ..","$ cd dthhvrln","$ ls","206159 wvvczgd.wzs","$ cd ..","$ cd jrhp","$ ls","dir bqf","5738 rgpwf","dir zjhw","$ cd bqf","$ ls","dir clgjfn","58416 fcr","216467 mcdqnw.prv","288978 zthdgfhl.lqq","$ cd clgjfn","$ ls","274929 lwnpggm.mfp","$ cd ..","$ cd ..","$ cd zjhw","$ ls","dir cbwrrzwh","dir fdz","dir grcj","219439 grcj.szv","285756 mfmps","113288 mmg.cpr","236059 nmq","dir pbnfdq","74013 tvmswr","dir zgqjbf","$ cd cbwrrzwh","$ ls","223425 zgqjbf.ffm","$ cd ..","$ cd fdz","$ ls","dir wbtzsr","$ cd wbtzsr","$ ls","257781 hzf","$ cd ..","$ cd ..","$ cd grcj","$ ls","58266 dcgvw","dir rhncgdll","dir vzgpfd","12503 zgv.ndt","$ cd rhncgdll","$ ls","dir vnmbhbhc","$ cd vnmbhbhc","$ ls","10019 lfcggd.ccw","$ cd ..","$ cd ..","$ cd vzgpfd","$ ls","134965 zdsp.tzg","78684 zmjjvf.glv","$ cd ..","$ cd ..","$ cd pbnfdq","$ ls","173729 frqdqhw","dir fvjc","41055 svwd","106934 tngzpl.lml","dir zqhjjjd","$ cd fvjc","$ ls","88907 pcvcpptp.dsr","133102 tszsbtjp.lfl","$ cd ..","$ cd zqhjjjd","$ ls","61260 mpdlcjl","dir wfw","$ cd wfw","$ ls","dir jrhp","dir lwg","226393 rndnc","dir zhrtj","$ cd jrhp","$ ls","276912 dcgvw","dir pwrjq","dir zmnv","$ cd pwrjq","$ ls","198180 vclfmjf.tfp","$ cd ..","$ cd zmnv","$ ls","84228 mfmps.wzw","$ cd ..","$ cd ..","$ cd lwg","$ ls","dir jrhp","50562 lwcfwjh.dtm","145174 vnl","$ cd jrhp","$ ls","86877 dcgvw","$ cd ..","$ cd ..","$ cd zhrtj","$ ls","284728 rsgsrn","$ cd ..","$ cd ..","$ cd ..","$ cd ..","$ cd zgqjbf","$ ls","202268 zqpvm","$ cd ..","$ cd ..","$ cd ..","$ cd vzgpfd","$ ls","138188 djqqfrbn.cps","$ cd ..","$ cd ..","$ cd lmnmthm","$ ls","2715 fqdm.bvm","37482 jdsn.zpr","255467 nscv.wvb","175914 stvscbg","$ cd ..","$ cd mfmps","$ ls","288712 gldg.jrd","182389 jrhp","dir lvjg","41815 nscv.wvb","dir vzgpfd","dir zgqjbf","dir zvpnq","$ cd lvjg","$ ls","184529 wcfpqqp.tcf","$ cd ..","$ cd vzgpfd","$ ls","265556 hjqng.glq","$ cd ..","$ cd zgqjbf","$ ls","dir dqmbmlrf","dir grcj","dir hlsr","$ cd dqmbmlrf","$ ls","dir bdvhvwct","254123 bzhhm.rqp","172950 fgqbj.bcb","7417 fjfq.qbv","188707 hfvvlvqg.sqh","78273 ppljtfjr.hpm","dir zgqjbf","$ cd bdvhvwct","$ ls","76840 gldg.jrd","dir grcj","$ cd grcj","$ ls","dir vzgpfd","$ cd vzgpfd","$ ls","73163 mfmps.tnr","$ cd ..","$ cd ..","$ cd ..","$ cd zgqjbf","$ ls","62316 lpzsww","$ cd ..","$ cd ..","$ cd grcj","$ ls","160721 bwvgdqdr","$ cd ..","$ cd hlsr","$ ls","214688 vzgpfd","$ cd ..","$ cd ..","$ cd zvpnq","$ ls","34940 gjbzp.nqg","165326 mfmps.gfp","dir rwddqchj","dir ssw","dir zgqjbf","$ cd rwddqchj","$ ls","dir gnsndln","$ cd gnsndln","$ ls","223320 zgqjbf.wlm","$ cd ..","$ cd ..","$ cd ssw","$ ls","dir grcj","$ cd grcj","$ ls","251146 gldg.jrd","$ cd ..","$ cd ..","$ cd zgqjbf","$ ls","45732 vzgpfd.nbz","86126 zdnv.sss","$ cd ..","$ cd ..","$ cd ..","$ cd pcplzs","$ ls","90287 grcj","99213 rsgsrn","dir shmsp","156357 tgc.lzp","dir thbznt","dir vtqlszrs","dir vzgpfd","$ cd shmsp","$ ls","dir jrhp","$ cd jrhp","$ ls","132784 tmlntm","$ cd ..","$ cd ..","$ cd thbznt","$ ls","190697 mdj.lll","270626 wcfpqqp.tcf","$ cd ..","$ cd vtqlszrs","$ ls","44292 dcgvw","$ cd ..","$ cd vzgpfd","$ ls","13921 hccgnjqh.cdl","dir jrhp","23850 jvq","113952 mfmps","dir ppdfjqbr","dir vdpvzhrs","190631 vzgpfd","128060 wclfwhv.chh","dir wghzqb","$ cd jrhp","$ ls","237755 bgbmnpq","19551 dcgvw","$ cd ..","$ cd ppdfjqbr","$ ls","1458 dcgvw","563 gldg.jrd","155487 glhjmpm.sjt","dir vthf","dir vzgpfd","81314 zgqjbf.scm","$ cd vthf","$ ls","205316 vzgpfd.qlg","$ cd ..","$ cd vzgpfd","$ ls","46597 mfmps.zsq","$ cd ..","$ cd ..","$ cd vdpvzhrs","$ ls","13302 vcwrr.jvb","$ cd ..","$ cd wghzqb","$ ls","dir grcj","dir hbngsg","112293 jzvh.pvf","282888 smrq.lvp","$ cd grcj","$ ls","258764 nscv.wvb","230478 qpqgf","$ cd ..","$ cd hbngsg","$ ls","101699 bzwnwz.tgj","144196 hwjrgtt.pdm","dir mthnljv","$ cd mthnljv","$ ls","1397 jrhp.rvp","$ cd ..","$ cd ..","$ cd ..","$ cd ..","$ cd ..","$ cd pvfbjm","$ ls","251602 nscv.wvb","$ cd ..","$ cd rnl","$ ls","233954 dqlncnds.dfn","dir nswpmqdd","$ cd nswpmqdd","$ ls","261883 rtpbgm.gbf","$ cd ..","$ cd ..","$ cd wqgp","$ ls","23813 pdfcfc","$ cd ..","$ cd zgqjbf","$ ls","15126 bvlbrq.pdj","dir jnjqhzh","dir smrzsq","dir vzgpfd","$ cd jnjqhzh","$ ls","243919 htdqwdc.nsr","254015 ppclcr.rms","234928 zmjr.hnt","$ cd ..","$ cd smrzsq","$ ls","dir ljvbmm","$ cd ljvbmm","$ ls","235241 jmcbrbdl.ccr","$ cd ..","$ cd ..","$ cd vzgpfd","$ ls","dir bhwd","38855 dcgvw","dir hdcqm","dir swcvhtmp","dir zgqjbf","118104 zhtlsdb.ncw","$ cd bhwd","$ ls","122018 gldg.jrd","dir lmjr","dir mfmps","$ cd lmjr","$ ls","40588 dcgvw","$ cd ..","$ cd mfmps","$ ls","dir grcj","$ cd grcj","$ ls","165840 zwbvbfj","$ cd ..","$ cd ..","$ cd ..","$ cd hdcqm","$ ls","156543 qfb.vhv","$ cd ..","$ cd swcvhtmp","$ ls","227964 rrfnsqw.rvh","$ cd ..","$ cd zgqjbf","$ ls","94269 mfmps.jsq","266360 rsgsrn","252761 zlz","$ cd ..","$ cd ..","$ cd ..","$ cd ..","$ cd zlv","$ ls","127388 nscv.wvb",
    ]
  end
end

Day7.run()
