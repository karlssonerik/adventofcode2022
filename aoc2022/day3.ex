defmodule Day3 do
  def run do
    IO.puts(part1(input(), 0))
    IO.puts(part2(input(), 0))
  end


   def part1(inputList, sum) do
     cond do
      length(inputList) == 0 ->
        sum
      true ->
        slots = getSlots(String.graphemes(hd(inputList)))
        common = commonElems(elem(slots,0),elem(slots,1))
        part1(tl(inputList), sum+slotValue(common,0))
    end
  end

  def part2(inputList, sum) do
    cond do
      length(inputList) == 0 ->
        sum
      true ->
        elf1 = String.graphemes(hd(inputList))
        elf2 = String.graphemes(hd(tl(inputList)))
        elf3 = String.graphemes(hd(tl(tl(inputList))))
        common = commonElems(elf3,commonElems(elf1,elf2))
        part2(tl(tl(tl(inputList))), sum+slotValue(common,0))
    end
  end

  def slotValue(commonEs, sum) do
    if length(commonEs) != 0 do
       i = :binary.first(hd(commonEs))
      if i>96 do
        slotValue(tl(commonEs), sum+i-96)
      else
        slotValue(tl(commonEs), sum+i-38)
      end
    else
      sum
    end
  end


  def commonElems(slotA, slotB) do
    Enum.uniq(Enum.filter(slotA, fn x -> Enum.member?(slotB, x) end))
  end

  def getSlots(flatSlots) do
    l = length(flatSlots)
    {Enum.take(flatSlots, div(l,2)), Enum.take(flatSlots, (-1)*(div(l,2)))}
  end

  def inputEX do
    ["vJrwpWtwJgWrhcsFMMfFFhFp","jqHRNqRjqzjGDLGLrsFMfFZSrLrFZsSL","PmmdzqPrVvPwwTWBwg","wMqvLMZHhHMvwLHjbvcjnnSBnvTQFn","ttgJtRGJQctTZtZT","CrZsJsPPZsGzwwsLwLmpwMDw",]
  end

  def input do
    [
      "NJvhJcQWTJWTNTFFMTqqGqfTmB","VwVzPldRZVLVRmfsvfjvqfmm","ZDPDHZHVcvDhbvnv","FHHwHBzzVCWWmmCzCPrVmgBwbLTtRFFbbbttRGRLjTcLpbbT","vhZZvdsNSdSMdNvjncppCLcLnGnj","CDZZsNZMZqdNSdlNZCqrzPHDzgrgzwVVWwmwwm","ndlndntsFJntFvccLjjLrjBShcBBfc","GpCGHzVwmmzqQWSSSfWHBhQL","mpCMGGCZVzVwGGVwmJsZnFtZnTSTJtdsvl","nCnPDGmDNmVCsVQDmGSWqvzchWSjjcWGqS","gTnBRLpfTRnrTdZgdLfRdrThvqcvWWhFFWvcFSSgjqqzjv","pfZfTMwrbLTTfsbmQtlVtHHnbs","wNdSdsbTvTZMTvTv","rrdRWdWQhFVdHWBGWQmmmnnMvCfmnhvmCmtZ","rJrVDRWpGddpbSlNSlspPP","chTNrthMMwWMTjfsmRzZszJpwm","BLnFFCngbcBnbbldDlpRjGpmsCzGsGsRGmmG","dqvnvlgbqtcPPMhH","QcLNqZbCzJDQBJJRpwzRpdnRldgnpf","GmmmvVGsHrWffrlwdCWd","CMsFVVFjCmFStGQbbLZNBbJBcTjc","LQVggbQvcLbQLHgvVLhWGGsChssrMWfzGccc","qDnRTTRqJttPfWMChJhGslWlzh","qRTRwPBTBtRZdnjnqqqnQVbjbNLFbbfLgVmgHLQm","cZbzwCwZPlJcMLrNSNfHWNBBNZ","vsQsDCqtsDhmtjVrBNWNjBHrhr","TtDTGnvTlgbbRCGg","BgBlplHlsgNNsJlVpBtPwJhMPRRQSSttRtSP","bvhTnmdFTzddStwStQRddt","ZnZDLvnvqZzbbhFzzmTbnFsVjVlNgsCCNVsVLpNWVgsB","TdptqrrcVGhhzFtw","DRnSfwJlDmmDDVGv","RCSQNSCQZndwbcMqQrBB","wvRlrlwVwwqzgbZRdCJBWfmdzCWfBdhf","cFcsQpNtLLsGTtNGpMdPmDdPBmmBvJPWvDtC","TpjssTFFvLLLcFFQpwbwwHngjHRrZRqZVH","mqqddrPPcPmqPDlrQnjTrbvMvbHzzsjjpTvz","gtBWgGgVhLGWHzMDztzstDHj","hfWRhBBNBGgLNQDPwdNPcPdw","LhQzdhhbTzpMhddhhhTzhnZcBFllHZFtrrHZHMHFjlHr","mwwssqDvjptrvplr","NCSgVDPDwmDgVJVpLfTznQJdhfLhnhQQ","GzjzDhjhhZzcrRgQCBjBPBBjQCgT","vHHHmntsbSgLwbsSmNHbwNbvpqPCBVppCpFTpTPTBtqWBCqV","NJbwNSwdndvmvwhGhgzcfMcDJfgJ","GncgDvvcMGnttjDvrgRRFSZZLZFWdJFJwGQwZBWZ","bPqpChPfsshfZZBdZdLTFZ","lNqqsClmbsNlPbHqPsmblmsrHdvdMngcVrjggvrvggRDcn","bDvtgVVVpMQvjQWmQL","rwTflmlfZJBBdQWQWjQqdM","HsJJmZZwscHrwTrcRbzpcbPgtCSbgz","CsCsRvshMjpbqCqf","ncblgDBgtDmmmTlBgwlgbHHqMFHLqPDMHPHHpqWfFM","TcBctSmTZTtSTzsZvsvJZRsGVb","znznvngttwltzlLwhtThHbqHPvNbNHSSHmmNWHjP","FBcLrRMFQpPqpPSpqHHW","fRQMJZJfrcMcMVrQJJftnwCzVCltgTnstTVnVL","MfLlRfCMrLzRlQgwNqQFcsGd","jtTjjBTvbdqcGjqFcj","vvShDSBDppzhCmzq","plWMptTvfrnncvcRfwqzqLGhzhzThNzNNJqD","jSdSHFPQQbdPCQCssjSbBmhJGNZZNGNqqJNBlJqqLh","VCCCVCQgjdddjCgljCjbbwgRRttgrpftfWrgvpwpnf","MWlbBcPjjvvjPWWMPqgRQZfJZDGGbRZJffQQwh","HrHrnncHpzrJQJfVDQVR","zzsSTtSTLzsspSdtTmHHmpmtFgqcgPlgFqWBqqqBMdWWvFlg","nSqBbJbqlnBBClVZcMgZVgcP","FQwrwHrRwWWFBRPNgNgcCGZZZC","rWFWFTwpwwWzHrnDbfJDLDbBBbbz","BMmNtLMMtFCNFNMvvLmcndpgcdgppPrgrGPPrgJD","WVWWhbTtVnGpjrrPhr","HWssSTHWfRHRsQQFLvfvFFCLCNMNlt","sTmDsQffVrrLCjTFltTFWL","BnwwQBJbJndMMRzMwCLlWlLWWCWLLtRlWF","cqqBMcMqwnznMGzcvDmQhrvssHmPDVssrP","pQGQGJDDrDVJbbfVzvvgPcCZwhZhncscZWWc","SqMMlBBljMmRlchhPTqThCZnPs","FMjMBmjRNFHQJJpHVhVDhG","tHNNdBdNtBBBMgsMpsZm","wVPzVvbwqzhrVqvjqzzsZpDsZDsZmsCPCgZgCM","bVbvLThvvbrWqHmmnJLdHdJQLn","PzTspPZpdLLDZTplPLpPDpvbfhnqNvqzfvNMzQQfNwnQ","GWRHmjmFWMMSnhbhHw","JWWcmtBrBtWBFWGJpsgTgldhLVLpJl","DwLMDzLMhvMcwvgdVqWWlCVgvlqF","TTSBBRpbStHZVgjWFldjRVlV","SnbTBdJBmnpQzMPDMcMznr","nNlMNBPPNtJQnbZhZsgSbh","czzCjcwTdvSbgQNcgNQq","VTdNdGDTzDTdlFFPtBrtLtDr","FMbbfMlzvFsmgVZmmg","SrNTHGmdSQDqLhtQhhgggs","dRDTSDPPcHRdHGDHlwJBbmwljmMcfjbW","sQgWLtqLtWhdqlpNZRpG","blTHTjlvTCJnJvRZdGGhHHGZhFGV","CCDlJclnCmbrmBMgcwcLWtcBsB","vqPWWvqwwCFvFZfZPRFRrcGQrQwsDrNcrwnbDNcQ","LVgJLSBBVtzTLzBMmTMJmLnnDNQcrsGbsQbNbrbDjs","zggVSmmhVdfqFhvHWG","WwdndGGmmmLwwwmRwWSncLRnZqZqhqZthBtqtBqZBgtdtvMH","FfHHzlQQDsFzzrNsVTfttZvTvttTqqtbqb","lQjFDNQFPjCsVCCDjGCwwSGGnccwcHppGp","mrjggcFsFMjdjZRpSZpn","NCqfLCFNbQPzPPlPzNfSRTRZdSdWWwndpqRSSd","vDvzzbPQFNCFtllLLNMBhMcDHGBGMggMmcBc","jhjlBvvnjbtDNPjtSjBDBbDNgHggrQrhghRQrqRrZcRwwqVg","pLdTMsWdLLmpMdqZZdPdVqZgHPwH","WLTCGmMLfPSlbGjlnnJD","gtbwhgHbHgqqbgQthgQLtZZCRjMcjjnRnrRNJmMRJrNhRc","bGWVTTvDvfpVFFBpvvVTdRDMJcrccCrJnMRnNnNCcc","FVWTBsdvdTzTBFWssVQtLgSQtHqqPzPbqHbw","dlzrPTSSjSrllzWhsvVmVtTRTWtf","bJMpLGcqGhNbJQttVQmmvRWWsp","qLbMwqqbGHFGzrlZrjhPHCrj","rNrrffVlqqrfLlPpltcBBTTGRzzZRPRsBTcJ","msbsmWSsMmQwjdMbWMhMhQmcRZRzGjTBGTBcBJBjCHJGcC","FwWbvdhbmrsFrfrgsN","rHjrQHdhdQrvSddcHWLssBSVVpBSWWWWWf","JNfTGtqDwVWBMBMpwM","qlltZgfJFvcRgcRjvc","CqfcwfDqwwmRnnqmRdNRBTRTRrdGdNpTvF","WVbzsZszBbrsvpdMpdQM","tJhbVZHWLLHDgnSwnSSgHB","TZCqqlTsqpZVVsZQJSBSLpLmppnJzmFz","brSgNtGjjRjRRjDddDtrRJcJJbJmmwcmBmnPcJFwFB","jgdRtMjNNjfqlMvShvSZSZ","dJTdqCwMNCgqTQllGBdlGBmmmZ","fcVfVcnbVfrwDLWVfncZBQPlBHRGljLZQjHGQl","brwnnfSFDvfzCTqFzgMJTh","njnsPBjjsrrnGLnbTTjGvcldQPCMllNzMvRQPCdd","ggZgfZtmZVpqZqZWDgFmgqfCcQRcRcWhQcccQddMcvRQdQ","tfqgggVgHpDwDtfwbGLJRjbLjsrLTj","JmrfrmTlDWTfgQCdHCdpqBvQdD","jsZtVzNsSNVQQHnBlVQR","PljljFjPljSsLPtFLTTgTcFrrfMJmrrmrr","hmGcmmndhmGnfmtGnDzFLwrFJQsQFzNFrNJG","ZSqPlSWcWlbgqWVTVWRVZPrjQqjzjFNJzLsNJsLJNqNL","RHcWTZbSMMMPgZcWgSWPPbVMDnBffmtdpDBddfnnvmCdfC","vSJvsbFfJfvqCsTHJswssJnLTZjjhzrrzLrzLMrzhdjM","pBNQDPcpmWDcBNgMMnZPVjdddnndhH","QWlDgmpmgDBlGRgDDgffSqwSwGCwHfvqwSFJ","jvlgvMJclPdGdtdcjMVmMHbFHFVHWHbZHZ","CwhLzLhzQpnqfpfqDVHCHbsbDFZDmHmj","LnBzfQjSzQrPvJvdSSrr","wpcvcsqclDCnVCVvWfnZ","BLRMRtbnbbBLNCjNCjVVZhbC","rFgMPSRnrRpmqpJwqFDs","LZQNQbMrZppLNLQplvlGLNvVmmmfjbwVCfjbwJwCmBCwfj","ShTPRFtTHZPCsnwswsFwCF","WtHRPdThSqZTRtDqtdRWTdpGDLLzrNczvzMGLlQLGDDM","hdcffBvldjhCMljqPwWwWNwWdwqHZr","LtQmbQRVsZQZMZPQSN","tmMRsJMpDhjJzJhv","wNQCMFCDQDBmrHmmRWrrHN","SShLnfqpcqpSZSfrzJvRVrvfrrJH","cRpqdGclpScltTQQtsFQMQsTCT","NCjggZmgfBgnBmgWbcwcTFctcWWfvb","HsDGthRGrtppSQpbFFJTVcJdFbTRvd","rPDGhDDrSzZLtzBLZMCB","RsBBMBsCBlFFCgRsBJzlMjMPNSdPhSrSrzLbmSDrDNmDSd","pZHZZJpGHHHpTTHvTncZqVLdqLbhLrDLdhrSLLbLDDdD","tGtwnJccvCtCffMBgt","wbddvVjfwPhbjjbDbbvbjvTNCNmfHZfpCZRJNzCmJmnJNC","BslcLtclZWsZJWNrRRNRpRmR","BSLBlScGtFMcssMBBFGLlQZTDZQjPddVwwbTdvvdhTZb","NSZHzmLZBnzHmLLzLSntDttDDtddhDtttDWW","QgfjsrrvNNJwtMddcvcvtq","jrfgfQpQrTTVLSNBClFV","GQWcWWPPQRcrJQNDdRcDmmLCFSnqNSmqhCNvFnql","zHfwjzpMjwZmCLqvvnlljC","ZgtVZBtHHZtgQGgPrbPRJdPv","TWdWpJTJTdgLWfWLlLFLrfrgBGsNqhGslBGHqSNqqBNshnws","ZpQmjzbZZCjZCCCPZtttRCCwsBnHNssBHbShsshHqsGBqN","RDRRPpPCzmZCtRpVVJFrfTfWFLLJggJrDv","pDDFlglsvFMgntlTMMqNffmTdfddRM","jhGJLVCHQpHGQCCzLjWdTTdZZdNdcRWNccWfNN","jQjSGjrjCQLhzVSLSCSHGDpngbrnDFtFBwBglBnBvg","wsLzstsgszcpcGLHGpcgcghlDBvQvjQvbFbQCbJBtCCJJv","mnSqRSSqSRThWRnmWWRSJDFTFCFCblbBCFQFCjFj","rZRRWqSSdZZfMVnZLspPsMgHpzMhHGPg","mwHrCLSWWwrsHCHDDsVrsmhfFZFnSSBlFlgZbbgBglbggj","GJdpcRtGJvNRdcPtdpJJdbQZfjfQBlnQBjnBtbfFnB","qcPpqqzFzJqvPVCCmWrVwhrWrz","jjMbvbhDvnRjNRGMmjbMZftSSwwwthJSffStctcwqd","lTQrVlpCVvCcfdcSJqLVcw","srHFWCHrFlrHlrsBsprljjRmDZZnmbDngNBgbNZv","MgTlQJlTQJZWpgLrRssrVqqqpRts","bBNbbzSSjMBPjzhMjsPtRVVRVPRqLttGGs","SjHBbfjNCDfjZgTlZdMJnDJW","lpThgTwtplhghgwhThqnnrdZctSZSjSZcRSRfbdrrc","RBVBGvmBmfdrcvrbbr","PmVGNGmmGRLLQwwLqTnglQ","nHwnBwBTnFHQwRsMhwghmzcm","GtprdCpdtqWdbqbrfdnPPszsWmRzRnShPszS","dGptbCfCrlnVDBJNLDLLVDLQ","CZtCjhTndCzqbCNq","dwpGvpsmwGslDszrNNrzqDMzWMgJ","vmcGccvpBVPTVTjTdTTTdZ","jWZhvZLjZfCZDwrDrSSzJGhVdJccscGsgV","blMBlRqqqgSJLBLcsJ","blmHLmFMMMnRqLmMMFqHmfPDfjQDnCDDQrZvfCjvDr","rnvnHrDLFZmMFLvrHQBMGQggBztzglplRl","sbWWhdNzsshsfhcsjJJPPbWdtQGVGllRTRjRRgBgQlpRlppB","PPCCwNWhPhNfWCzbqmFnDFFnCDLSrvZS","GChNjwWlWJWTJZBggvdgnQgdhdnd","HPsHfHHrpHDpFFrcSfsfpCMmQdntLBMgtmtBgDdLLC","SqpPscpPzpSWzjlCjjCGjl","nvgLvcLgvgvngbLprpJNTDCCRNVJrNPlDDTV","WZsMtsffGQtMzWFqFmWmWsVNJNlDwwCDVRTwJlCCDVLz","BQfGZGmmsMWFstWFmfMsfBccdncbpbSbvbbvHnLbpc","tsmDsvswNZmcZTccfh","zCTpGCbWBRWFWHGRFZJbMbJfnrhnhfMnnZ","TzFGFBRLdpHHNNQddDQDvwQN","fhBBpJgdHddjZQfmVmNzNNLmFN","qvMRrvlbwqlbTTMBMvLssFNmVzzwFDmLLzVD","TRSRWqRRMcBHhGHcdGgPGp","lSjHmtmnpHStblnpSlHSrtmMzLWzqzqCZDDTzTTWqMFqCqVV","sLRLLfPPRQfCTqqVVqFT","dNJgRPNQNsJJhBRvdJvQvNNsjSrrSmrcctpbpHtBrBjLjmSH","nwFwpppjfwSlpLTsqsTgNshhjM","ccBRGvtsmgGNPqNNGP","BCcJHvssdcWBCVmVHSSrZrwVzblpwbzZnf","rcfQRrBPPczjcRBctZDNlnVNHbgZGjVDjN","TvMsFJGSFMhJnNZlwVVnDNTZ","qhSqqmqLCLhFdJLqSvLhmQRQRWcRPczPtzrCrWGRBp","JVhdPhsFPFqLDBHVdHLPvhHDCMwcgJJwbwRgnnCMbwGwcmGC","fzjzpTZTQQQLwCbgGgbMmQcR","jzNpTzfSZtfNSWZlVVtdFFFDHHqLHVqv","TwSNnSnSGVTpNppGlPTlTcVqQrRhVBqdqBRqZqQZqQ","DcDCMfDbCMHJdrRBqbdjRBRZ","gvftMCJHcHfCDmDLgfMmMmmWlwWnWsTTwlGTlWTwppNlGL","pbGMbllDQPhhWWQDpPgVGlMCvRRrQLcCCcfBBQzLBcvQBv","wqnJjSmjrstdqwwFBLcRsBRRszzLFC","qwdddTJTdHtjndqJqHZHmwVWGpDbGTlbWWpWWrPGhhhM","WGllqLjjLCpSffmBmvfpHs","dnrQwZzRTdZwnCThdzzFTVmcBHBJBmsHfBPHcfvcSVHs","QgQrzCdrTRCZzrZLbjGLqNMWGgNNLt","sgPnhPPTTPTTwlJfwNHlqcfs","LMCpFbLLbRpMGbMcCFLVlNlNqrHqVfbHHwNDwr","GjBcCCtWMtMRZTSvgWQTngvg","BCMtJJMpRDlMMvBJBBnfjtcjPhPmZgnhgdcf","NrsrsqFNvrVLVGVrsHsqFgfmcPGdcmhfjdPgfjcnZd","zFTzsNqHqFssLVLQqNTFbsBDwCCwvWlDwRMRCTRBDMDS","zQtLgvggSRtgvVRtLvvnzdnjnGwGdmmrlpnlGz","JssBFpqsDqPNnlWWjrrjqrnj","DHDFBNDfPbJBsFHNMPvpvStQvMRVTtgVTVtv","FvzttFvBTJJzLbvwhCnnVnWwjCnBNC","mQdZgZPDPdPPSsMSQPdZgCwVGmnwnWpGnGhqNWjWCG","ggdDgfQSdcjtFHjlLJfF","ghcgScNNSsCvGSzmpVFlZbrzcFcV","MWWRLRqqqdQwTtLjjmqMlFpFlzVnbFVDwplFzlDr","LHMHqdHWjdQMdMtLHHLtWjJRsGCGSNghmSvPBJBNhsGfvfGP","CbVqqqDbcbMHnnDqcCbrRFCfBvvwGjzrBwQGzrwwBjGwBQ","sTPmpNWdWPTJssSSLPfNljjBvflGtjwwBzMG","mmWgmgSZLTLMZWpnhqZbhFFCnhqnnn","QQmjmZqnmQrfTZlbbcVbBcfbHfzf","vpdSNShNppFdSRtdGBqvJBDlDzqbPPHVBH","tRNSNRFhNpSRhFRMFtGhRGswLZZsZqWnmrmZwqwsTZmmmQ","gGWCllFCGWtGGWdlGlWNZdwpnnSbwpMvpphZpndn","RsshDDLcQVMSJQwJwnvw","HVPzrPcDNhPFGhPC","jtHQGHjGGtdTLjnqTQlmvRPRPBBwRBnFPPWP","hZbzNzVrczZzcbNssVspZZVvBwbmPmJPWmvbBRvPlmvRJF","fzNVDsZMhzpVhpVhlZcMNfcDDdQTLTjGDTCqGCjtSQHdHL","GrbFggGrTrzSrgfwJjdTmwmNJZJd","VMPQplPDptchwdsjmlml","MqMWtBDPPWDWHQtvqQtWPjbzCGLgSBgGbzgrzFgnnz","fcJccCcwcDfcpbRnCfWJnQJqtqtqPQdsGdgPsgTQqg","LSjVMhzSFFrljdNbltNGtgdqQq","MMhSHFFMLzBWDcHHcfcHwb","rwmWtJWMwSNRJMtwNmMrrSsmtTjjlgqnTqZZZPlHnTngTTgn","BGqGqqFBFggjjdGHlj","QDhhLbDQCDFMNcmhRhqJNW","BnRnRvMnLGLSCHvvSnlRfWbbTNQJsJsbNbJTBfQT","tzMmmMwjhcpFjDmMcptrcjzFQggfQPTsWsfgNbbgfhJbPhQT","FdzcrtDwDMtcwtFGRZdRLvdnHRSZZv","HVpsSpvjpNjsBmbGFBnMNnDM","WRRWhZtfrVtLJrBZMnDmDbnZBTGF","thhPLzWzhzwPtLRLWrQlpPvvClcVcCppSvpl","lZPbhnZLRPnnPZZPdlGMBWcBMgMQHBBcvvvzBL","jpFjmwwwCDDbsjvjjgcvQgcNBQ","rbFmppbwhqhGRGZr","ggrLwFgWCBwbMWBbFwLMgNBZdmZHclJPllnJlNRPmSNZRR","ppszzDfhDfhsqpnvDVTfGpSPlPmclHcdRcZmmmdPPGSP","pvtDDVDVpqDfzDfngBLCwQrgCtCwFwrg","pbGjFFGGDjpbsGsmNhNFNRBBBtRhhhHv","JnczJVCvwWJvhPgghgNtNtNJ","nwVSSzdzzqSpvQSZQG","mssLLttQrsMrMzLCRmMmrrSQpvWpDNlBTBDlvNTccDQl","HdHJwJqVPwHnqJwbjJbGjnSgSTWPpNgWWpgBBgcvDWWN","ZHVwVZGwwdndqJVJqfHbGwnwrRLtLMftMvMMRrhmLMthhLmz","RgHGLbTqlZlPRZPHfvvfZttJnvfvjnzr","sVcChDVDccwNhhvjTvVzWJjnzFff","mpNcCMTCGmLqBLGH","wVJwHJHVMtMpBmDDWPQVPWDGDD","zCrlZzCblBvnCDWNGLmvGDLPNG","dqZglgbzrzbbgZqzTFSBHHFJSSSfjjSMfwhj","NMWJSjLMCnHHNMNNHWCHMbVVGBPZTrPVPBVDrBSDGTTr","zvttlFpgdtldwwvftPDPTWQdBZrsrWrGBZ","hFlFmhRFvfCbmWJWHcnj",
    ]
  end
end

Day3.run()
